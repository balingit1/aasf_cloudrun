variable "project" {
  description = "Project ID"
}

variable "region" {
  default = "australia-southeast1"
  description = "Default region"
}

variable "credentials_file" {
  description = "Service accout private key file"
}

variable "repo_id" {
  description = "Artifact registry name"
}

variable "repo_desc" {
  description = "Artifact registry description"
}

variable "cloudrun_service" {
  description = "Cloud run service name"
}

variable "docker_source" {
  description = "The source code URI"
}

variable "docker_image" {
  description = "Name of docker image to be created"
}

variable "tag1" {
  description = "Tag of the docker image"
}
