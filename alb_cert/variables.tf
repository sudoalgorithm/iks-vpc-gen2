##############################################################################
# Variables
##############################################################################


variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
}

variable resource_group_id {
    description = "ID for resource group"
    type        = string
}

variable enable_alb_cert {
    description = "Enable ALB cert. Use only if albs are enabled"
    type        = bool
}

variable bring_your_own_cms {
    description = "Bring your own certificate managemant instance. If false, one will be created"
    type        = bool
}

variable cms_name {
    description = "Name of certificate management instance"
    type        = string
}

variable cms_plan {
    description = "Name of the plan for CMS. Use only if `bring_your_own_cms` is false"
}

variable tags {
    description = "A list of tags to add to the cluster"
    type        = list(string)
}

variable certificate_name {
    description = "Name of the ALB certificate to import"
    type        = string
}

variable cluster_id {
    description = "ID of cluster where cert should be added"
}

##############################################################################