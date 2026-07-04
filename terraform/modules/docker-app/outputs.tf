output "network_id" {
  description = "ID of the Docker network"
  value       = docker_network.exam_network.id
}

output "nginx_container_id" {
  description = "ID of the Nginx container"
  value       = docker_container.nginx.id
}

output "health_checker_container_id" {
  description = "ID of the health-checker container"
  value       = docker_container.health_checker.id
}