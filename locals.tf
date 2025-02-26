locals {
  # All workspace specific variables that are loaded based on the active workspace.
  ws_var  = provider::terraform::decode_tfvars(file("${terraform.workspace}-env.tfvars"))

  default_tags = {
    ApplicationName = var.app_name
    Environment     = local.ws_var.env_name
    workspace       = terraform.workspace
    terraform       = true
  }
}
