output "host" {
  description = "Hostname of the Redis container."
  value       = docker_container.server.hostname
}

output "port" {
  description = "Port bound by Redis."
  value       = var.port
}

output "password" {
  description = "Redis authentication password."
  sensitive   = true
  value       = var.password
}
