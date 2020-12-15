##############################################################################
# CMS Instance
##############################################################################

module cms {
    source            = "../resource_data"
    enable_service    = var.enable_alb_cert
    use_data          = var.bring_your_own_cms
    name              = var.cms_name
    service           = "cloudcerts"
    plan              = var.cms_plan
    ibm_region        = var.ibm_region
    end_points        = "private"
    tags              = var.tags
    resource_group_id = var.resource_group_id
}

##############################################################################


################################################################################
# Create and Import ssl cert for testing and load certificate to CMS
################################################################################

resource ibm_certificate_manager_import cert {

    count  = var.enable_alb_cert ? 1 : 0
    certificate_manager_instance_id = module.cms.id

    name        = var.certificate_name
    description = "string"
    data        = {
        # content      = file("${path.module}/certs/cert.pem")
        # priv_key     = file("${path.module}/certs/private.key")
    }
  
}

################################################################################


##############################################################################
# Enable ALB cert for cluster
##############################################################################

resource ibm_container_alb_cert cert {
    count       = var.enable_alb_cert ? 1 : 0
    cert_crn    = element(ibm_certificate_manager_import.cert.*.id, count.index)
    secret_name = var.certificate_name
    cluster_id  = var.cluster_id
}

##############################################################################