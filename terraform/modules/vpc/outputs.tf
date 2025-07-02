output "urn" {
  description = "The URN of the VPC"
  value       = digitalocean_vpc.vpc.urn
}

output "id" {
  description = "The ID of the VPC"
  value       = digitalocean_vpc.vpc.id
}

output "ip_range" {
  description = "The IP range of the VPC in CIDR notation"
  value       = digitalocean_vpc.vpc.ip_range
}
