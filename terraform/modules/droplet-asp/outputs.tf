output "autoscale_urn" {
  description = "The URN of the autoscaling group"
  value       = digitalocean_droplet_autoscale.asg.urn
}

output "id" {
  description = "The ID of the autoscaling group"
  value       = digitalocean_droplet_autoscale.asg.id
}