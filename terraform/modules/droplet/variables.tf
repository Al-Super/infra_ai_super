variable "name" {
  description = "Name to be used on all the droplets as identifier"
  type        = string
}

variable "image" {
  description = "Docker image to run on the Droplet"
  type        = string
}

variable "size" {
  description = "Slug of the Droplet size"
  type        = string
}

variable "region" {
  description = "Slug of the Droplet region"
  type        = string
}

variable "user_data" {
  description = "User data to be used on the Droplet"
  type        = file
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC to be used on the Droplet"
  type        = string
}

variable "ssh_key_ids" {
  description = "List of SSH key IDs to be added to the droplet"
  type        = list(string)
  default     = []
}