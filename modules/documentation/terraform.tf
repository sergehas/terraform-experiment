# Defines provider requirements for the documentation module.
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
  # Provider functions require Terraform 1.10 and later.
  required_version = ">= 1.10.0"
}
