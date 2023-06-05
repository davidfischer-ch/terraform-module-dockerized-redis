variable "identifier" {
  type = string
}

variable "enabled" {
  type = bool
}

variable "image_id" {
  type        = string
  description = "Redis image's ID."
}

variable "data_directory" {
  type = string
}

# Logging

variable "error_log_level" {
  type    = string
  default = "warn"
  # TODO check if ...
}

# Authentication

variable "password" {
  type      = string
  sensitive = true
}

# Networking

variable "network_id" {
  type = string
}

variable "port" {
  type    = number
  default = 6379
}
