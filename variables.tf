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
  default     = true
}

variable "wait" {
  type        = bool
  description = "Wait for the container to reach an healthy state after creation."
  default     = true
}

variable "image_id" {
  type        = string
  description = "Redis image's ID."
}

# Process ------------------------------------------------------------------------------------------

variable "app_uid" {
  type        = number
  description = "UID of the user running the container and owning the data directories."
  default     = 999
}

variable "app_gid" {
  type        = number
  description = "GID of the user running the container and owning the data directories."
  default     = 999
}

variable "privileged" {
  type        = bool
  description = "Run the container in privileged mode."
  default     = false
}

variable "cap_add" {
  type        = set(string)
  description = "Linux capabilities to add to the container."
  default     = []
  validation {
    condition = length(setsubtract(var.cap_add, local.linux_capabilities)) == 0
    error_message = "Each entry in `cap_add` must be a valid Linux capability name."
  }
}

variable "cap_drop" {
  type        = set(string)
  description = "Linux capabilities to drop from the container."
  default     = []
  validation {
    condition = length(setsubtract(var.cap_drop, local.linux_capabilities)) == 0
    error_message = "Each entry in `cap_drop` must be a valid Linux capability name."
  }
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  description = "Add entries to container hosts file."
  default     = {}
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type        = number
  description = "Bind the Redis port."
  default     = 6379

  validation {
    condition     = var.port == 6379
    error_message = "Having `port` different than 6379 is not yet implemented."
  }
}

# Storage ------------------------------------------------------------------------------------------

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

# Configuration ------------------------------------------------------------------------------------

variable "log_level" {
  type        = string
  description = "Redis log level."
  default     = "warning"

  validation {
    condition     = contains(["debug", "verbose", "notice", "warning"], var.log_level)
    error_message = "Log level should be one of `debug`, `verbose`, `notice`, `warning`"
  }
}

variable "databases" {
  type        = number
  description = "Set the number of databases."
  default     = 1

  validation {
    condition     = var.databases >= 1
    error_message = "Argument `databases` must be at least 1."
  }
}

# Authentication -----------------------------------------------------------------------------------

variable "password" {
  type        = string
  description = "Redis authentication password."
  sensitive   = true
}
