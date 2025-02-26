# backend for the state file storage
terraform {
backend "local" {
    path = "./terraform.tfstate"
  }
}