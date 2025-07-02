variable "name" {
  description = "VPC name"
  type        = string
}

variable "region" {
  description = "DigitalOcean VPC region"
  type        = string
}

variable "description" {
  description = "VPC description"
  type        = string
  default     = "VPC for DigitalOcean resources"
}

variable "ip_range" {
  description = "The range of IP addresses for the VPC in CIDR notation"
  type        = string
  default     = null  # Let DigitalOcean assign a default range
}