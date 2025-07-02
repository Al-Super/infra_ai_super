resource "digitalocean_droplet_autoscale" "asg" {
  name = var.name

  config {
    min_instances             = var.min_instances
    max_instances             = var.max_instances
    target_cpu_utilization    = var.target_cpu_utilization
    target_memory_utilization = var.target_memory_utilization
    cooldown_minutes          = var.cooldown_minutes
  }

  droplet_template {
    image              = var.image
    size               = var.size
    region             = var.region
    with_droplet_agent = true
    ipv6               = true
    vpc_uuid           = var.vpc_id

    user_data = var.user_data

    ssh_keys = [
      digitalocean_ssh_key.ssh_key.id
    ]

    tags = [
      digitalocean_tag.droplet.name
    ]
  }
}