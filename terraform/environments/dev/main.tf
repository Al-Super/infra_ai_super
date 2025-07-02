module "vpc" {
  source = "../../modules/vpc"
  name   = "${local.name}-vpc"
  region = local.region
}

resource "digitalocean_project" "dev_playground" {
  name        = "${local.name}-${local.environment}"
  description = var.description
  environment = local.environment
}

resource "digitalocean_volume" "dev_playground" {
  name   = "${local.name}-volume"
  region = local.region
  size   = 10
}

resource "digitalocean_project_resources" "dev_playground" {
  project = digitalocean_project.dev_playground.id
  resources = [
    module.backend_droplet.autoscale_urn,
    module.llm_model.autoscale_urn,
    digitalocean_volume.dev_playground.urn,
    digitalocean_spaces_bucket.pdf_bucket.urn,
    module.mysql.database_cluster_urn,
    module.vpc.urn
  ]
}

resource "digitalocean_ssh_key" "dev_playground" {
  name       = "${local.name}-${local.environment}"
  public_key = var.ssh_key
}

module "container_registry" {
  source = "../../modules/docr"
  name   = "${local.name}-docr"
  region = local.region

  subscription_tier_slug = "starter" // Change if another docker image would be needed
}

module "backend_droplet" {
  source      = "../../modules/droplet"
  name        = "${local.name}-backend"
  region      = local.region
  size        = var.droplet_size
  image       = var.droplet_image
  vpc_id      = module.vpc.id
  ssh_key_ids = [digitalocean_ssh_key.dev_playground.id]
}

module "llm_model" {
  source      = "../../modules/droplet"
  name        = "${local.name}-llm"
  region      = local.region
  size        = var.llm_droplet_size
  image       = var.droplet_image
  vpc_id      = module.vpc.id
  ssh_key_ids = [digitalocean_ssh_key.dev_playground.id]
}

module "mysql" {
  source = "../../modules/mysql"

  name            = "${local.name}-mysql"
  region          = local.region
  backend_droplet = module.backend_droplet.id
  vpc_id          = module.vpc.id
}

resource "digitalocean_spaces_bucket" "pdf_bucket" {
  name   = "${local.name}-pdf"
  region = local.region
}

# Firewall for internal communication
resource "digitalocean_firewall" "internal" {
  name = "${local.name}-internal-fw"

  # Allow all traffic between droplets in the same VPC
  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = ["${module.vpc.ip_range}"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    source_addresses = ["${module.vpc.ip_range}"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["${module.vpc.ip_range}"]
  }

  # Apply to both droplets
  droplet_ids = [
    module.backend_droplet.id,
    module.llm_model.id
  ]
}

# digitalocean pdf bucket policy

# alerts for the backend
resource "digitalocean_monitor_alert" "cpu_utilization_backend" {
  description = "CPU Utilization Alert for Backend"

  window   = "5m"
  type     = "v1/insights/droplet/cpu"
  compare  = "GreaterThan"
  value    = 95
  enabled  = true
  entities = [module.backend_droplet.id]

  alerts {
    email = var.emails
  }
}

resource "digitalocean_monitor_alert" "memory_utilization_backend" {
  description = "Memory Utilization Alert for Backend"

  window   = "5m"
  type     = "v1/insights/droplet/memory"
  compare  = "GreaterThan"
  value    = 95
  enabled  = true
  entities = [module.backend_droplet.id]

  alerts {
    email = var.emails
  }
}

resource "digitalocean_monitor_alert" "backend_health" {
  description = "Backend Health Alert"

  window   = "5m"
  type     = "v1/insights/droplet/health"
  compare  = "GreaterThan"
  value    = 0
  enabled  = true
  entities = [module.backend_droplet.id]

  alerts {
    email = var.emails
  }
}
