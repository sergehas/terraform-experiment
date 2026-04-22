# Defines Terraform core and provider version requirements.
terraform {
  # Provider functions require explicit required_providers declarations.
  required_providers {

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

    terraform = {
      source = "terraform.io/builtin/terraform"
    }
  }
  # Provider functions require Terraform 1.10 and later.
  required_version = ">= 1.10.0"
}
