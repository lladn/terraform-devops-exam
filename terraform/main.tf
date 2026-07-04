terraform {
  required_providers {
    gitea = {
      source = "go-gitea/gitea"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "gitea" {
  base_url = var.gitea_base_url
  token    = var.gitea_token
}

provider "docker" {}

resource "gitea_repository" "exam_repo" {
  username = var.gitea_username
  name     = var.repository_name
  private  = var.repository_private
}

resource "gitea_repository_branch_protection" "main_protection" {
  username    = gitea_repository.exam_repo.username
  name        = gitea_repository.exam_repo.name
  rule_name   = "main"
  enable_push = true   
}

module "docker_app" {
  source = "./modules/docker-app"

  network_name    = var.docker_network_name
  volume_name     = var.docker_volume_name
  nginx_image     = var.nginx_image
  curl_image      = var.curl_image
  nginx_host_port = var.nginx_host_port
  labels          = var.container_labels
}