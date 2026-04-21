locals {
  # All workspace specific variables that are loaded based on the active workspace.
  ws_var_file = "envs/${terraform.workspace}.tfvars"

  # Enforce: workspace must not be default
  _enforce_not_default = (
    terraform.workspace == "default"
    ? file("ERROR: Workspace 'default' not allowed. Execute: terraform workspace select <workspace_name>")
    : true
  )

  # Enforce: tfvars file must exist for the selected workspace
  _enforce_file_exists = (
    fileexists(local.ws_var_file)
    ? true
    : file("ERROR: Required tfvars file missing: ${local.ws_var_file}")
  )

  # Load workspace-specific variables (validation checks run first)
  ws_var = (
    local._enforce_not_default && local._enforce_file_exists
  ) ? provider::terraform::decode_tfvars(file(local.ws_var_file)) : null

  default_tags = {
    ApplicationName = var.app_name
    ApplicationSize = local.ws_var.app_size
    Environment     = local.ws_var.env_name
    Workspace       = terraform.workspace
    Terraform       = true
  }
}
