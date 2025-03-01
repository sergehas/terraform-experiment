variable "env_name" {
  description = "The name of the environment"
  type        = string
}

variable "app_size" {
  description = "Size of the application"
  type        = string
}

variable "features" {
  description = "List of features"
  type        = list(string)
  default     = []
}

variable "paths" {
  description = "Paths for the build"
  type = object({
    build = string
  })
  default = {
    build = "build"
  }
}

