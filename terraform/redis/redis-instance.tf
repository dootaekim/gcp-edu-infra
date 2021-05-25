resource "google_redis_instance" "k_c_redis" {
  provider = google
  project = var.project_id
  name = var.name
  memory_size_gb = 1

  location_id = var.zone_A
  alternative_location_id = var.tier == "STANDARD_HA" ? var.zone_B : null

  authorized_network = var.network_name
  connect_mode = "PRIVATE_SERVICE_ACCESS"

  redis_version = "REDIS_4_0"
  display_name = "Managed by Terraform"

  redis_configs = {
    "maxmemory" : "allkeys-lru"
    "activedefrag" : "yes"
  }
}