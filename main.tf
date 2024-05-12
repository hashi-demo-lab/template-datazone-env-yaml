
data "tfe_outputs" "domain" {
  organization = var.tfc_organization
  workspace    = var.datazone_workspace_name
}

locals {
  datazone_config          = yamldecode(file("${path.module}/config/${var.datazone_domain_yaml_file}"))
  datazone_domain   = local.datazone_config.datazone
  datazone_env      = local.datazone_config.datazone_environment
}

module "datazone_environment" {
  source  = "app.terraform.io/tfc-demo-au/datazone-environments/awscc"
  version = "~>  0.1.5"

  region                        = var.region
  domain_id                     = coalesce(var.domain_id, data.tfe_outputs.domain.values.datazone_domain_id)
  project_map                   = coalesce(var.project_map, data.tfe_outputs.domain.values.projects)
  blueprint_map                 = coalesce(var.blueprint_map, data.tfe_outputs.domain.values.datazone_environment_blueprints)
  datazone_environment_profiles = var.datazone_environment_profiles
  datazone_environments         = var.datazone_environments
}