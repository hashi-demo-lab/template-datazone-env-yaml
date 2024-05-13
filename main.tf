
data "tfe_outputs" "domain" {
  organization = var.tfc_organization
  workspace    = local.datazone_domain.tfe_workspace
}

locals {
  datazone_config          = yamldecode(file("${path.module}/config/${var.datazone_domain_yaml_file}"))
  datazone_domain   = local.datazone_config.datazone
  datazone_env      = local.datazone_config.datazone_environments
  domain_existing   = try({ domain_id="${data.tfe_outputs.domain.nonsensitive_values.datazone_domain_id}" }, {})
}

output "tfe_outputs" {
  value = local.domain_existing
}

module "datazone_environment" {
  source  = "app.terraform.io/tfc-demo-au/datazone-environments/awscc"
  version = "~>  0.1.7"

  for_each = local.domain_existing

  region                        = local.datazone_env.region
  domain_id                     = coalesce(var.domain_id, data.tfe_outputs.domain.nonsensitive_values.datazone_domain_id)
  project_map                   = coalesce(var.project_map, data.tfe_outputs.domain.values.projects)
  blueprint_map                 = coalesce(var.blueprint_map, data.tfe_outputs.domain.values.datazone_environment_blueprints)
  datazone_environment_profiles = local.datazone_env.datazone_environment_profiles
  datazone_environments         = local.datazone_env.datazone_environments
}