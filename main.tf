resource "local_file" "sample_file" {
  content  = "sample content for sample file"
  filename = "${paths.build}/sample-${app_size}.txt"
}