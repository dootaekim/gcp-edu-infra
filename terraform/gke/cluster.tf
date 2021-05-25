resource "google_container_cluster" "gke_cluster" {
  provider                  =   google-beta
  project                   =   var.project_id
  name                      =   var.cluster_name
  location                  =   var.region #Set region (not a zone) for regional
  description               =   var.cluster_description
  remove_default_node_pool  =   true
  initial_node_count        =   1
  default_max_pods_per_node =   30
  min_master_version        =   var.min_master_version

  network                   =   var.network_name
  subnetwork                =   var.subnet_name
  node_locations            =   ["asia-northeaset3-a","asia-northeast3-b"]

  release_channel {
      channel   =   "REGULAR"
  }

  ip_allocation_policy {
      cluster_secondary_range_name  =   var.cluster_secondary_range_name
      services_secondary_range_name =   var.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes        =   true
    enable_private_endpoint     =   false
    master_ipv4_cidr_block      =   var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
        cidr_block      =   "122.37.120.150/32"
        display_name    =   "Fowler's Public IP"
    }

    cidr_blocks {
        cidr_block      =   "35.216.31.19/32"
        display_name    =   "Jenkins Public IP"
    }
  }

  network_policy {
    provider    =   "CALICO"
    enabled     =   true
  }

  enable_intranode_visibility   =   true

  workload_identity_config {
    identity_namespace  =   "${var.project_id}.svc.id.goog"
  }

  authenticator_groups_config {
    security_group  =   "gke-security-groups@${var.project_id}.iam.gserviceaccount.com"
  }

  master_auth {
    username    =   ""
    password    =   ""

    client_certificate_config {
      issue_client_certificate  =   false
    }
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }   
    network_policy_config {
      disabled = false
    }
    istio_config {
      disabled = true
    }
  }
}