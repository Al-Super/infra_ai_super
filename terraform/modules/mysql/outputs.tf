output "database_cluster_urn" {
  description = "The URN of the MySQL database cluster"
  value       = digitalocean_database_cluster.mysql.urn
}

output "database_cluster_id" {
  description = "The ID of the MySQL database cluster"
  value       = digitalocean_database_cluster.mysql.id
}