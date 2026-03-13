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
  default     = true
  description = "Toggle the containers (started or stopped)."
}

variable "wait" {
  type        = bool
  default     = true
  description = "Wait for the container to reach an healthy state after creation."
}

variable "image_id" {
  type        = string
  description = "Redis image's ID."
}

# Process ------------------------------------------------------------------------------------------

variable "app_uid" {
  type        = number
  default     = 999
  description = "UID of the user running the container and owning the data directories."
}

variable "app_gid" {
  type        = number
  default     = 999
  description = "GID of the user running the container and owning the data directories."
}

variable "privileged" {
  type        = bool
  default     = false
  description = "Run the container in privileged mode."
}

variable "cap_add" {
  type        = set(string)
  default     = []
  description = "Linux capabilities to add to the container."
}

variable "cap_drop" {
  type        = set(string)
  default     = []
  description = "Linux capabilities to drop from the container."
}

# Storage ------------------------------------------------------------------------------------------

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
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
