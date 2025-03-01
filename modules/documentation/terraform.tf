# Configuration using provider functions must include required_providers configuration.
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">2.5.0"
    }
  }
}
