provider "awscc" {
    region = local.datazone_env.region
}

provider "aws" {
    region = local.datazone_env.region
}