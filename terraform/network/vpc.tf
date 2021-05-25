resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  mtu  = 1500
  routing_mode = "GLOBAL"
  auto_create_subnetworks = false
}