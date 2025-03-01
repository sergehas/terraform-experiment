
# This test checks if the documentation file is created with the correct name

# mocks the local provider
mock_provider "local" {}

run "create_documentation_default_path" {
  variables {
    env_name = "unit-test"
    app_size = "smallest"
  }

  module {
    source = "./modules/documentation"
  }
  #this is the default command...
  command = apply

  assert {
    condition     = local_file.documentation_file.filename == "build/doc-unit-test-smallest.md"
    error_message = "filename should be 'build/doc-unit-test-smallest.md'"
  }
}

run "create_documentation_with_path" {
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
