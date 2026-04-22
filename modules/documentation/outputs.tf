# Exposes generated file metadata from the documentation module.
output "documentation_filename" {
  description = "Filename of the generated documentation file"
  value       = local_file.documentation_file.filename
}

