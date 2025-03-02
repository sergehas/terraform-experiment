variable "do_version" {
  description = "Enable version module"
  type        = bool
  default     = false

}

module "version" {
  count          = var.do_version ? 1 : 0
  source         = "./modules/version"
  actual_version = "1.0.0-LIVE"
}
