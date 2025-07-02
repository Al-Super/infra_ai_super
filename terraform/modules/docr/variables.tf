variable "name" {
  description = "Name of the Container Registry"
  type = string
}

variable "region" {
  description = "Region where the Container Registry will be deployed"
  type = string
}

variable "subscription_tier_slug" {
  description = "Subscription tier slug for the Container Registry"
  type = string
  default = "starter"
}