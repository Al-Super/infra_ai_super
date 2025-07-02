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

variable "min_instances" {
  description = "Minimum number of instances to be running"
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances to be running"
  type        = number
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization for autoscaling"
  type        = number
}

variable "target_memory_utilization" {
  description = "Target memory utilization for autoscaling"
  type        = number
}

variable "cooldown_minutes" {
  description = "Cooldown period in minutes"
  type        = number
  default     = 5
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the droplet in"
  type        = string
  default     = null
}