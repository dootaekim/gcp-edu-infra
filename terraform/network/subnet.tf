resource "google_compute_subnetwork" "sbn-k-c" {
  name          = "sbn-k-c"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-northeast3"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "sbn-k-c-gke-dev" {
  name          = "sbn-k-c-gke-dev"
  ip_cidr_range = "10.3.1.0/24"
  region        = "asia-northeast3"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  secondary_ip_range = [ 
    {
      ip_cidr_range = "240.220.0.0/18"
      range_name = "sbn-an3-dev-gkenode-pods"
    },
    {
      ip_cidr_range = "240.221.0.0/18"
      range_name = "sbn-an3-dev-gkenode-svc"
    },
  ]
}

