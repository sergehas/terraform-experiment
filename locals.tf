# Computes shared values, workspace inputs, and guardrails for root execution.
locals {
  version_package_file = abspath(var.version_package_file)

  # Load the committed package file only when versioning is explicitly enabled.
  version_package_data = (
    var.do_version && fileexists(local.version_package_file)
  ) ? provider::terraform::decode_tfvars(file(local.version_package_file)) : {}

  resolved_current_version = try(local.version_package_data.version, var.current_version)

  # All workspace specific variables that are loaded based on the active workspace.
  ws_var_file = "envs/${terraform.workspace}.tfvars"

  # These guard locals intentionally call file() with an invalid path to raise a
  # readable error when workspace prerequisites are not met.
  # Enforce: workspace must not be default.
  _enforce_not_default = (
    terraform.workspace == "default"
    ? file("ERROR: Workspace 'default' not allowed. Execute: terraform workspace select <workspace_name>")
    : true
  )

  # Enforce: tfvars file must exist for the selected workspace.
  _enforce_file_exists = (
    fileexists(local.ws_var_file)
    ? true
    : file("ERROR: Required tfvars file missing: ${local.ws_var_file}")
  )

  # Load workspace-specific variables only after both guard checks pass.
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
