resource "digitalocean_container_registry" "digitalocean_container_registry" {
  name                   = var.name
  region                 = var.region
  subscription_tier_slug = var.subscription_tier_slug
}
