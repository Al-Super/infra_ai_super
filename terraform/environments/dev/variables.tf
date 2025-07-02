variable "description" {
  default = "Project for Dev environment of AI Super"
  type    = string
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "region" {
  type = string
}

variable "droplet_size" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "The size of the backend droplet"
}

variable "llm_droplet_size" {
  type        = string
  default     = "s-2vcpu-4gb"
  description = "The size of the LLM model droplet (needs more resources)"
}

variable "droplet_image" {
  type        = string
  default     = "ubuntu-20-04-x64"
  description = "The image of the droplet"
}

variable "ssh_key" {
  type        = string
  description = "ssh key path"
}

variable "target_cpu_utilization" {
  type    = number
  default = 70
}

variable "target_memory_utilization" {
  type    = number
  default = 70
}

variable "do_token" {
  description = "Digital Ocean API Token"
  type        = string
}

variable "emails" {
  description = "Emails to send alerts to"
  type        = list(string)
  default     = ["example@example.com"]
}