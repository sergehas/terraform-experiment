locals {
  # All workspace specific variables that are loaded based on the active workspace.
  ws_var = provider::terraform::decode_tfvars(file("envs/${terraform.workspace}.tfvars"))

  default_tags = {
    ApplicationName = var.app_name
    ApplicationSize = local.ws_var.app_size
    Environment     = local.ws_var.env_name
    Workspace       = terraform.workspace
    Terraform       = true
  }
}
