output "new_version" {
  description = "The newly computed semantic version"
  value       = local.new_version
}

output "package_file_content" {
  description = "Terraform locals declaration that stores the computed version"
  value       = local.package_file_content
}

output "package_file_name" {
  description = "Default filename for the generated Terraform package file"
  value       = local.package_file_name
}

