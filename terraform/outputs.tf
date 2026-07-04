output "repository_clone_url" {
  description = "HTTP clone URL of the Gitea repository"
  value       = gitea_repository.exam_repo.clone_url
}

output "repository_web_url" {
  description = "Web URL of the Gitea repository"
  value       = gitea_repository.exam_repo.html_url
}

output "docker_network_id" {
  description = "ID of the Docker network"
  value       = module.docker_app.network_id
}

output "nginx_container_id" {
  description = "ID of the Nginx container"
  value       = module.docker_app.nginx_container_id
}

output "health_checker_container_id" {
  description = "ID of the health-checker container"
  value       = module.docker_app.health_checker_container_id
}