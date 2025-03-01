output "env_name" {
  description = "sample output"
  value       = local.ws_var.env_name
}

output "tags" {
  description = "tags"
  value       = local.default_tags
}

output "ws_variables" {
  description = "All workspace variables"
  value       = local.ws_var
}
