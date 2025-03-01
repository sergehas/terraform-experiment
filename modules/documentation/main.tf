# main module : create resources

resource "local_file" "documentation_file" {
  content  = <<EOT
# Where am I?

I'm the content for **${var.env_name}** environment!

## Features
%{for f in var.features}
* ${f}%{endfor}
EOT
  filename = "${var.paths.build}/doc-${var.env_name}-${var.app_size}.md"
}
