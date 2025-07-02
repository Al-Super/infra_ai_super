variable "name" {
  description = "Name of the mysql"
  type        = string
}

variable "size" {
  description = "Size of the mysql"
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "region" {
  description = "Region of the mysql"
  type        = string
}

variable "cluster_id" {
  description = "Cluster ID of the mysql"
  type        = string
  default     = null
}

variable "timeout" {
  description = "Timeout of the mysql"
  type        = string
  default     = "5m"
}

variable "backend_droplet" {
  description = "Backend droplet of the mysql firewall"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy the database in"
  type        = string
  default     = null
}