# Configures local backend state storage.
terraform {
  backend "local" {
    path = ".terraform/terraform.tfstate"
  }
}
