variable "network_name" {
  description = "Name of the Docker network to create"
  type        = string
}

variable "volume_name" {
  description = "Name of the Docker volume to create"
  type        = string
}

variable "nginx_image" {
  description = "Nginx image (repo:tag) to deploy"
  type        = string
}

variable "curl_image" {
  description = "curl image (repo:tag) used for the health-check container"
  type        = string
}

variable "nginx_host_port" {
  description = "Host port mapped to the Nginx container's port 80"
  type        = number

  validation {
    condition     = var.nginx_host_port >= 1024 && var.nginx_host_port <= 65535
    error_message = "nginx_host_port must be between 1024 and 65535."
  }
}

variable "labels" {
  description = "Common labels applied to every container (project, environment, managed-by)"
  type        = map(string)
}