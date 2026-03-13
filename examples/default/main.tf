resource "docker_image" "redis" {
  name         = "redis:7.4.2"
  keep_locally = true
}

resource "docker_network" "app" {
  name   = "my-app"
  driver = "bridge"
}

resource "random_password" "broker" {
  length  = 32
  special = false
}

module "broker" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-redis.git?ref=1.2.0"

  identifier = "my-app-broker"
  image_id   = docker_image.redis.image_id

  # Networking

  network_id = docker_network.app.id

  # Storage

  data_directory = "/data/my-app/broker"

  # Configuration

  databases = 2

  # Authentication

  password = random_password.broker.result
}
