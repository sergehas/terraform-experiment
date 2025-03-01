# Configuration using provider functions must include required_providers configuration.
terraform {
  required_providers {

    terraform = {
      source = "terraform.io/builtin/terraform"
    }
  }
  # Provider functions require Terraform 1.8 and later.
  required_version = ">= 1.8.0"
}
