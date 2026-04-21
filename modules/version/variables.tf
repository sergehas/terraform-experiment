variable "actual_version" {
  description = "Version string written into the generated version file"
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.actual_version))
    error_message = "actual_version must match MAJOR.MINOR.PATCH (for example, 1.2.3)."
  }
}

variable "bump_part" {
  description = "Part of semantic version to increment"
  type        = string

  validation {
    condition     = contains(["major", "minor", "patch"], var.bump_part)
    error_message = "bump_part must be one of: major, minor, patch."
  }
}

variable "prerelease" {
  description = "Optional prerelease suffix to append to the computed version"
  type        = string
  default     = ""
}
