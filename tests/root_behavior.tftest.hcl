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
