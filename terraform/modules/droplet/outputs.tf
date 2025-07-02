output "id" {
  description = "ID of droplet"
  value       = digitalocean_droplet.droplet.id
}

output "autoscale_urn" {
  description = "URN of droplet (for compatibility with autoscale module)"
  value       = digitalocean_droplet.droplet.urn
}

output "ipv4_address_private" {
  description = "Private IPv4 address of the droplet"
  value       = digitalocean_droplet.droplet.ipv4_address_private
}