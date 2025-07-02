resource "digitalocean_tag" "droplet" {
  name = "${var.name}-tag"
}

resource "digitalocean_droplet" "droplet" {
  name     = var.name
  image    = var.image
  size     = var.size
  region   = var.region
  ipv6     = true
  vpc_uuid = var.vpc_id

  user_data = var.user_data

  ssh_keys = var.ssh_key_ids

  tags = [
    digitalocean_tag.droplet.name
  ]
}