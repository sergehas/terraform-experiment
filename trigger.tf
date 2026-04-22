variable "do_version" {
  description = "Enable generation of the package version file"
  type        = bool
  default     = false
}

variable "current_version" {
  description = "Current semantic version in format MAJOR.MINOR.PATCH"
  type        = string
  default     = "1.0.0"
}

variable "version_bump_part" {
  description = "Part of the semantic version to bump"
  type        = string
  default     = "patch"

  validation {
    condition     = contains(["major", "minor", "patch"], var.version_bump_part)
    error_message = "version_bump_part must be one of: major, minor, patch."
  }
}

variable "version_prerelease" {
  description = "Optional prerelease suffix added to generated version"
  type        = string
  default     = "SNAPSHOT"
}

variable "version_package_file" {
  description = "Path to package HCL file used as version input when do_version is true"
  type        = string
  default     = "package.hcl"
}

module "version" {
  count          = var.do_version ? 1 : 0
  source         = "./modules/version"
  actual_version = local.resolved_current_version
  bump_part      = var.version_bump_part
  prerelease     = var.version_prerelease
}

resource "local_file" "package_file" {
  count = var.do_version ? 1 : 0

  content  = module.version[0].package_file_content
  filename = "${path.root}/${module.version[0].package_file_name}"
}
