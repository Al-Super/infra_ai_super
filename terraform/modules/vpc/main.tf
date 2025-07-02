resource "digitalocean_vpc" "vpc" {
  name        = var.name
  region      = var.region
  description = var.description
  ip_range    = var.ip_range
}
