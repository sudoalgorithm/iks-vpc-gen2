##############################################################################
# Create IKS on VPC Cluster
##############################################################################

resource ibm_container_vpc_cluster cluster {

  name              = var.cluster_name
  vpc_id            = data.ibm_is_vpc.vpc.id
  resource_group_id = data.ibm_resource_group.group.id
  flavor            = var.machine_type
  worker_count      = var.workers_per_zone
  kube_version      = var.kube_version != "" ? var.kube_version : null
  tags              = var.tags
  wait_till         = "IngressReady" #var.wait_till

  dynamic zones {
    for_each = data.ibm_is_subnet.subnet
    content {
      subnet_id = zones.value.id
      name      = zones.value.zone
    }
  }

  disable_public_service_endpoint = var.disable_public_service_endpoint
}

##############################################################################


##############################################################################
# Worker Pools
##############################################################################

module worker_pools {
  source            = "./worker_pools"
  ibm_region        = var.ibm_region
  pool_list         = var.worker_pools
  vpc_id            = data.ibm_is_vpc.vpc.id
  resource_group_id = data.ibm_resource_group.group.id
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  subnets           = [
      for i in data.ibm_is_subnet.subnet:
      {
          id: i.id
          zone: i.zone
      }
  ]
}

##############################################################################


##############################################################################
# ALBs
##############################################################################

resource ibm_container_vpc_alb alb {
  count  = var.enable_private_albs || var.enable_public_albs ? (2 * length(var.subnet_ids)) : 0
  alb_id = element(ibm_container_vpc_cluster.cluster.albs.*.id, count.index)
  enable = (
    (
      element(ibm_container_vpc_cluster.cluster.albs.*.alb_type, count.index) == "public"
      && var.enable_public_albs
      ) || (
      element(ibm_container_vpc_cluster.cluster.albs.*.alb_type, count.index) == "private"
      && var.enable_private_albs
    )
    ? true
    : false
  )
}

##############################################################################


##############################################################################
# ALB Cert
##############################################################################

module alb_cert {
  source             = "./alb_cert"
  enable_alb_cert    = var.enable_alb_cert && (var.enable_private_albs || var.enable_public_albs) ? true : false
  ibm_region         = var.ibm_region
  resource_group_id  = data.ibm_resource_group.group.id
  bring_your_own_cms = var.bring_your_own_cms
  cms_name           = var.cms_name
  cms_plan           = var.cms_plan
  certificate_name   = var.certificate_name
  cluster_id         = ibm_container_vpc_cluster.cluster.id
  tags               = var.tags
}

##############################################################################
