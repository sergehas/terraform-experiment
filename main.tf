# main module : create resources

resource "local_file" "sample_file" {
  content  = "# Where am I?\n\nI'm the content for **${local.ws_var.env_name}** environment!\n"
  filename = "${var.paths.build}/sample-${local.ws_var.env_name}-${local.ws_var.app_size}.md"
}