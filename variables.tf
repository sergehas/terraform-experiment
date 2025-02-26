variable "sample_number" {
  type        = number
  description = "A sample number variable"
  default     = 10
}

variable "app_size" {
  type        = string
  description = "a variable key info for sizing the env"
}

variable "paths" {
  type        = map(string)
  description = "A map of paths"
  default     = {
    build = "build"
    src   = "src"
  }
}   