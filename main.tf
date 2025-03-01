# main module : create resources

module "documentation" {
  source = "./modules/documentation"

  env_name = local.ws_var.env_name
  app_size = local.ws_var.app_size
  features = local.ws_var.features
  paths    = var.paths
}
