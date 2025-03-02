# main module : create resources

resource "local_file" "version_file" {
  content = <<EOT
local {
  version = "${var.actual_version}"
}
EOT

  filename = "${path.root}/version.tf"
}
