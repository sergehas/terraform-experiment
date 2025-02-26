resource "local_file" "sample_file" {
  content  = "sample content for sample file"
  filename = "./sample-${local.ws_var.env_name}-${local.ws_var.app_size}.txt"
}