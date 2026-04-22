# Computes the next semantic version and package file payload.
locals {

  /*
  Extract MAJOR.MINOR.PATCH from versions like 1.2.3 or 1.2.3-SNAPSHOT.
  This lets bump logic ignore optional prerelease suffixes during math.
  */
  version_without_prerelease = regex("^[0-9]+\\.[0-9]+\\.[0-9]+", var.actual_version)
  version_parts              = [for p in split(".", local.version_without_prerelease) : tonumber(p)]

  # Major bumps reset minor and patch; minor bumps reset patch.
  new_major = var.bump_part == "major" ? local.version_parts[0] + 1 : local.version_parts[0]
  new_minor = var.bump_part == "major" ? 0 : (var.bump_part == "minor" ? local.version_parts[1] + 1 : local.version_parts[1])
  new_patch = var.bump_part == "patch" ? local.version_parts[2] + 1 : 0

  base_new_version = "${local.new_major}.${local.new_minor}.${local.new_patch}"
  new_version      = var.prerelease != "" ? "${local.base_new_version}-${var.prerelease}" : local.base_new_version

  package_file_content = "version = \"${local.new_version}\""
  package_file_name    = "package.hcl"
}
