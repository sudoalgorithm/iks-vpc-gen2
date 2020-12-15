##############################################################################
# Account variables
##############################################################################

variable ibmcloud_api_key {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
    type        = string
}

variable generation {
    description = "Generation of VPC. Can be 1 or 2"
    type        = number
    default     = 2
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
}

variable resource_group {
    description = "Name for IBM Cloud Resource Group where resources will be deployed"
    type        = string
}

##############################################################################


##############################################################################
# VPC Variables
##############################################################################

variable vpc_name {
    description = "Name of VPC where cluster is to be created"
    type        = string
}


variable subnet_ids {
    description = "List of subnet ids"
    type        = list
    default     = []
}

##############################################################################


##############################################################################
# Cluster Variables
##############################################################################

variable cluster_name {
    description = "Name of cluster to be provisioned"
    type        = string
    default     = "demo-cluster"
}

variable machine_type {
    description = "The flavor of VPC worker node to use for your cluster"
    type        = string
    default     = "cx2.4x8"
}

variable workers_per_zone {
    description = "Number of workers to provision in each subnet. Opnshift cluster "
    type        = number
    default     = 1
}

variable disable_public_service_endpoint {
    description = "Disable public service endpoint for cluster"
    type        = bool
    default     = false
}

variable kube_version {
    description = "Specify the Kubernetes version, including the major.minor version. To see available versions, run ibmcloud ks versions. To use the default, leave string empty"
    type        = string
    default     = ""
}

variable wait_till {
    description = "To avoid long wait times when you run your Terraform code, you can specify the stage when you want Terraform to mark the cluster resource creation as completed. Depending on what stage you choose, the cluster creation might not be fully completed and continues to run in the background. However, your Terraform code can continue to run without waiting for the cluster to be fully created. Supported args are `MasterNodeReady`, `OneWorkerNodeReady`, and `IngressReady`"
    type        = string
    default     = "IngressReady"
}

variable tags {
    description = "A list of tags to add to the cluster"
    type        = list
    default     = []
}

variable worker_pools {
    description = "List of maps describing worker pools"
    # type        = list(
    #     object({
    #         pool_name        = string
    #         machine_type     = string
    #         workers_per_zone = number
    #     })
    # )
    default     = []
    #    {
    #        pool_name        = "dev"
    #        machine_type     = "c2.2x4"
    #        workers_per_zone = 1
    #        resource_group   = "default"
    #    },
    #    {
    #        pool_name        = "prod"
    #        machine_type     = "c2.2x4"
    #        workers_per_zone = 1
    #    }
    #]
}


variable enable_public_albs {
    description = "Enable public albs"
    type        = bool
    default     = true
}

variable enable_private_albs {
    description = "Enable private albs"
    type        = bool
    default     = true
}

##############################################################################


##############################################################################
# ALB Cert Variables
##############################################################################

variable enable_alb_cert {
    description = "Enable ALB cert. Use only if albs are enabled"
    type        = bool
    default     = false
}

variable bring_your_own_cms {
    description = "Bring your own certificate managemant instance. If false, one will be created"
    type        = bool
    default     = false
}

variable cms_name {
    description = "Name of certificate management instance"
    type        = string
    default     = "alb-cert-demo"
}

variable cms_plan {
    description = "Name of the plan for CMS. Use only if `bring_your_own_cms` is false"
    type        = string    
    default     = "free"
}

variable certificate_name {
    description = "Name of the ALB certificate to import"
    type        = string
    default     = "demo-alb-cert"
}

##############################################################################