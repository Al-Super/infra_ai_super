resource "digitalocean_droplet" "droplet" {
  name  = var.name
  image = var.image
  size  = var.size

  region = var.region

  tags = [
    digitalocean_tag.droplet.name
  ]
}
