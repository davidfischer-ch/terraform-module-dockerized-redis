variable "identifier" {
  type        = string
  description = "Identifier (must be unique, used to name resources)."
  validation {
    condition     = regex("^[a-z]+(-[a-z0-9]+)*$", var.identifier) != null
    error_message = "Argument `identifier` must match regex ^[a-z]+(-[a-z0-9]+)*$."
  }
}

variable "enabled" {
  type        = bool
  description = "Toggle the containers (started or stopped)."
}

variable "wait" {
  type        = bool
  default     = false
  description = "Wait for the container to reach an healthy state after creation."
}

variable "image_id" {
  type        = string
  description = "Redis image's ID."
}

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

variable "data_owner" {
  type        = string
  default     = "999:999"
  description = "Owner (UID:GID) for data directories."
}

# Logging ------------------------------------------------------------------------------------------

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
  description = "Set the number of databases."
}

# Authentication -----------------------------------------------------------------------------------

variable "password" {
  type      = string
  sensitive = true
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  default     = {}
  description = "Add entries to container hosts file."
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type    = number
  default = 6379

  validation {
    condition     = var.port == 6379
    error_message = "Having `port` different than 6379 is not yet implemented."
  }
}
