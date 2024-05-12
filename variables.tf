variable "datazone_domain_yaml_file" {
  description = "file name for datazone yaml"
  type        = string
  default = "rbs_payments.yaml"
}

variable "tfc_organization" {
  description = "The Terraform Cloud organization"
  type        = string
  default = "tfc-demo-au"
}

variable "domain_id" {
  description = "The domain to deploy the environment"
  type        = string
  default     = null
}

variable "project_map" {
  description = "The project to deploy the environment"
  type        = any
  default     = null
}

variable "blueprint_map" {
  description = "The environment blueprint to deploy"
  type        = any
  default     = null
}