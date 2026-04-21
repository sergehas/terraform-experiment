# This test validates the documentation module creates files with correct names.

mock_provider "local" {}

run "test_documentation_default_path" {
  command = plan

  variables {
    env_name = "unit-test"
    app_size = "smallest"
  }

  module {
    source = "./modules/documentation"
  }

  assert {
    condition     = local_file.documentation_file.filename == "build/doc-unit-test-smallest.md"
    error_message = "filename should be 'build/doc-unit-test-smallest.md'"
  }
}

run "test_documentation_with_custom_path" {
  command = plan

  variables {
    env_name = "unit-test"
    app_size = "smallest"
    paths = {
      build = "test-path"
    }
  }

  module {
    source = "./modules/documentation"
  }

  assert {
    condition     = local_file.documentation_file.filename == "test-path/doc-unit-test-smallest.md"
    error_message = "filename should be in the 'test-path' folder"
  }
}

run "test_documentation_content_includes_env_and_features" {
  command = plan

  variables {
    env_name = "production"
    app_size = "large"
    features = ["auth", "api", "cache"]
  }

  module {
    source = "./modules/documentation"
  }

  assert {
    condition     = can(regex("production", local_file.documentation_file.content))
    error_message = "documentation content should include environment name"
  }

  assert {
    condition     = length(regexall("auth[\\s\\S]*api[\\s\\S]*cache", local_file.documentation_file.content)) > 0
    error_message = "documentation content should list all features"
  }
}
