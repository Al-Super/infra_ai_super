resource "digitalocean_database_cluster" "mysql" {
  name       = "mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = var.size
  region     = var.region
  node_count = 1
  private_network_uuid = var.vpc_id
}

resource "digitalocean_database_mysql_config" "mysql" {
  cluster_id        = digitalocean_database_cluster.mysql.id
  connect_timeout   = var.timeout
  default_time_zone = "UTC"
}

# Firewall for MySQL Cluster
resource "digitalocean_database_firewall" "mysql-fw" {
  cluster_id = digitalocean_database_cluster.mysql.id

  rule {
    type  = "droplet"
    value = var.backend_droplet
  }
}