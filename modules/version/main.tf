locals {
  version_parts = [for p in split(".", var.actual_version) : tonumber(p)]

  new_major = var.bump_part == "major" ? local.version_parts[0] + 1 : local.version_parts[0]
  new_minor = var.bump_part == "major" ? 0 : (var.bump_part == "minor" ? local.version_parts[1] + 1 : local.version_parts[1])
  new_patch = var.bump_part == "patch" ? local.version_parts[2] + 1 : 0

  base_new_version = "${local.new_major}.${local.new_minor}.${local.new_patch}"
  new_version      = var.prerelease != "" ? "${local.base_new_version}-${var.prerelease}" : local.base_new_version
}
