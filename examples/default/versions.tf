terraform {
  required_version = ">= 1.6"

  required_providers {
    # https://github.com/kreuzwerker/terraform-provider-docker/tags
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }

    # https://github.com/NikolaLohinski/terraform-provider-jinja/tags
    jinja = {
      source  = "NikolaLohinski/jinja"
      version = ">= 1.17.0"
    }

    # https://github.com/hashicorp/terraform-provider-local/tags
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.1"
    }

    # https://github.com/hashicorp/terraform-provider-random/tags
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}
