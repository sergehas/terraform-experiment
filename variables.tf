variable "app_name" {
  type        = string
  description = "The name of the application"
  default     = "demo-app"
}

# variable "env_name" {
#   type        = string
#   description = "The name of the environment"
#   default     = "development"
#   # nullable    = false
# }

# variable "sample_number" {
#   type        = number
#   description = "A sample number variable"
# }

# variable "app_size" {
#   type        = string
#   description = "a variable key info for sizing the env"
#   # nullable    = false
# }

variable "paths" {
  type        = map(string)
  description = "A map of paths"
  default = {
    build = "build"
    src   = "src"
  }
}
