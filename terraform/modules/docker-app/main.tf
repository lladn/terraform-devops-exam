terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_network" "exam_network" {
  name = var.network_name
}

resource "docker_volume" "exam_web_data" {
  name = var.volume_name
}

resource "docker_image" "nginx" {
  name = var.nginx_image
}

resource "docker_container" "nginx" {
  name  = "exam-web-server"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.nginx_host_port
  }

  networks_advanced {
    name = docker_network.exam_network.name
  }

  volumes {
    volume_name    = docker_volume.exam_web_data.name
    container_path = "/var/cache/nginx"
  }


  healthcheck {
    test         = ["CMD", "nginx", "-t"]
    interval     = "30s"
    timeout      = "5s"
    retries      = 3
    start_period = "5s"
  }

  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}

resource "docker_image" "curl" {
  name = var.curl_image
}

resource "docker_container" "health_checker" {
  name  = "exam-health-checker"
  image = docker_image.curl.image_id

  networks_advanced {
    name = docker_network.exam_network.name
  }

  command = [
    "sh", "-c",
    "while true; do curl -sf http://exam-web-server:80 || echo 'Health check failed'; sleep 30; done"
  ]

  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
  }

  depends_on = [docker_container.nginx]
}