variable "gitea_base_url" {
  description = "Base URL of the Gitea instance"
  type        = string
  default     = "http://localhost:3000"
}

variable "gitea_username" {
  description = "Gitea username used for authentication and repo ownership"
  type        = string
}

variable "gitea_token" {
  description = "Gitea API access token (write:repository, write:user, read:organization, write:issue)"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "Name of the Gitea repository to create"
  type        = string
  default     = "terraform-docker-exam"
}

variable "repository_private" {
  description = "Whether the repository is private"
  type        = bool
  default     = true
}

variable "docker_network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "exam-network"
}

variable "docker_volume_name" {
  description = "Name of the Docker volume for the Nginx cache"
  type        = string
  default     = "exam-web-data"
}

variable "nginx_image" {
  description = "Nginx image to deploy"
  type        = string
  default     = "nginx:1.27.4"
}

variable "curl_image" {
  description = "curl image used for the health-check container"
  type        = string
  default     = "curlimages/curl:8.17.0"
}

variable "nginx_host_port" {
  description = "Host port mapped to the Nginx container's port 80"
  type        = number
  default     = 8081   

  validation {
    condition     = var.nginx_host_port >= 1024 && var.nginx_host_port <= 65535
    error_message = "nginx_host_port must be between 1024 and 65535."
  }
}

variable "container_labels" {
  description = "Common labels applied to every Docker container"
  type        = map(string)
  default = {
    project     = "devops-exam"
    environment = "development"
    managed-by  = "terraform"
  }
}