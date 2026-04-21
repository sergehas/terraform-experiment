# This test validates the version module computes semantic versions correctly.

run "test_bump_patch_version" {
  command = plan

  variables {
    actual_version = "1.0.0"
    bump_part      = "patch"
    prerelease     = ""
  }

  module {
    source = "./modules/version"
  }

  assert {
    condition     = output.new_version == "1.0.1"
    error_message = "patch bump should increment patch and clear prerelease"
  }
}

run "test_bump_minor_version" {
  command = plan

  variables {
    actual_version = "1.2.3"
    bump_part      = "minor"
    prerelease     = ""
  }

  module {
    source = "./modules/version"
  }

  assert {
    condition     = output.new_version == "1.3.0"
    error_message = "minor bump should increment minor and reset patch"
  }
}

run "test_bump_major_version" {
  command = plan

  variables {
    actual_version = "1.2.3"
    bump_part      = "major"
    prerelease     = ""
  }

  module {
    source = "./modules/version"
  }

  assert {
    condition     = output.new_version == "2.0.0"
    error_message = "major bump should increment major and reset minor and patch"
  }
}

run "test_bump_minor_with_prerelease" {
  command = plan

  variables {
    actual_version = "1.2.3"
    bump_part      = "minor"
    prerelease     = "SNAP"
  }

  module {
    source = "./modules/version"
  }

  assert {
    condition     = output.new_version == "1.3.0-SNAP"
    error_message = "version bump with prerelease should include suffix"
  }
}

run "test_invalid_version_format" {
  command = plan

  variables {
    actual_version = "invalid"
    bump_part      = "patch"
    prerelease     = ""
  }

  module {
    source = "./modules/version"
  }

  expect_failures = [
    var.actual_version
  ]
}

run "test_invalid_bump_part" {
  command = plan

  variables {
    actual_version = "1.0.0"
    bump_part      = "invalid"
    prerelease     = ""
  }

  module {
    source = "./modules/version"
  }

  expect_failures = [
    var.bump_part
  ]
}
