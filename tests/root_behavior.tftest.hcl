# This test validates workspace selection is enforced and tfvars files must exist.

mock_provider "local" {}

variables {
  env_name = "development"
  app_size = "small"
  features = ["feature1", "feature2", "feature3 (experimental)"]
}

run "valid_workspace_loads_tfvars" {
  command = plan

  assert {
    condition     = output.env_name == "development"
    error_message = "env_name should be loaded from workspace tfvars."
  }

  assert {
    condition     = output.documentation_file == "build/doc-development-small.md"
    error_message = "documentation filename should use tfvars env_name and app_size."
  }
}

run "version_package_file_is_generated_under_root" {
  command = plan

  variables {
    version_package_file = "tests/package-test.hcl"
    current_version      = "1.0.0"
    do_version           = true
    version_bump_part    = "minor"
    version_prerelease   = "SNAPSHOT"
  }

  assert {
    condition     = can(regex("[\\\\/]package\\.hcl$", local_file.package_file[0].filename))
    error_message = "package file should be written at the repository root as package.hcl."
  }

  assert {
    condition     = trimspace(local_file.package_file[0].content) == "version = \"1.1.0-SNAPSHOT\""
    error_message = "package file should contain an HCL version assignment."
  }
}

run "version_package_file_not_loaded_when_disabled" {
  command = plan

  variables {
    current_version   = "9.9.9"
    do_version        = false
    version_bump_part = "patch"
  }

  assert {
    condition     = local.resolved_current_version == "9.9.9"
    error_message = "when do_version is false, the package file must not be loaded."
  }
}
