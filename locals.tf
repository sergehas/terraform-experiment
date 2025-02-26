locals {
  default_tags = {
    ApplicationName = var.app_name
    Environment     = var.env_name
    workspace       = terraform.workspace
    terraform       = true
  }
}
