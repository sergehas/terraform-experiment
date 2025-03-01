# main module : create resources

resource "local_file" "sample_file" {
  content  = <<EOT
# Where am I?

I'm the content for **${local.ws_var.env_name}** environment!

## Features
%{for f in local.ws_var.features}
* ${f}%{endfor}
EOT
  filename = "${var.paths.build}/sample-${local.ws_var.env_name}-${local.ws_var.app_size}.md"
}
