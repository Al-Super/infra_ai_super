resource "digitalocean_database_mysql_config" "example" {
  cluster_id        = digitalocean_database_cluster.example.id
  connect_timeout   = 10
  default_time_zone = "UTC"
}

resource "digitalocean_database_cluster" "example" {
  name       = "example-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}

# Firewall for MySQL Cluster
resource "digitalocean_database_firewall" "example-fw" {
  cluster_id = digitalocean_database_mysql_config.example.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.web.id
  }
}