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

variable "log_level" {
  type    = string
  default = "warning"

  validation {
    condition     = contains(["debug", "verbose", "notice", "warning"], var.log_level)
    error_message = "Log level should be one of `debug`, `verbose`, `notice`, `warning`"
  }
}

variable "databases" {
  type        = number
  default     = 1
  description = "Set the number of databases"
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

  validation {
    condition     = var.port == 6379
    error_message = "Having `port` different than 5432 is not yet implemented."
  }
}
