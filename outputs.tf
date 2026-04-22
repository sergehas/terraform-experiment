# Exposes root outputs for generated artifacts and resolved workspace context.
output "documentation_file" {
  description = "Generated documentation filename"
  value       = module.documentation.documentation_filename
}

output "env_name" {
  description = "Resolved environment name from workspace tfvars"
  value       = local.ws_var.env_name
}

output "tags" {
  description = "Default tags applied to resources"
  value       = local.default_tags
}

output "ws_variables" {
  description = "All decoded workspace variables"
  value       = local.ws_var
  sensitive   = true
}
