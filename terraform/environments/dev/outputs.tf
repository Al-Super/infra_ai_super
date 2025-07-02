output "backend_droplet_private_ip" {
  value = module.backend_droplet.ipv4_address_private
}

output "llm_model_private_ip" {
  value = module.llm_model.ipv4_address_private
}

output "llm_api_endpoint" {
  value = "http://${module.llm_model.ipv4_address_private}:8000"
  description = "The API endpoint for the LLM model service"
}

output "ssh_connection_backend" {
  value = "ssh -i ~/.ssh/digitalocean root@${module.backend_droplet.ipv4_address_private}"
}

output "ssh_connection_llm" {
  value = "ssh -i ~/.ssh/digitalocean root@${module.llm_model.ipv4_address_private}"
}