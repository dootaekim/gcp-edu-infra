resource "google_service_account" "gke_node_pool_sa" {
  account_id = var.nodepool_name
  display_name = "Service Account for GKE Nodepool"
}



resource "google_project_iam_member" "kc_gke_sa_object_viewer" {
  role = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.gke_node_pool_sa.email}"
}

resource "google_project_iam_member" "kc_gke_sa_monitoring_writer" {
  role = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.gke_node_pool_sa.email}"
}

resource "google_project_iam_member" "kc_gke_sa_logging_writer" {
  role = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.gke_node_pool_sa.email}"
}

resource "google_project_iam_member" "kc_gke_sa_compute_instanceAdmin" {
  role = "roles/compute.instanceAdmin"
  member = "serviceAccount:${google_service_account.gke_node_pool_sa.email}"
}

resource "google_project_iam_member" "kc_gke_sa_serviceAccountUser" {
  role = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.gke_node_pool_sa.email}"
}


resource "google_container_node_pool" "kc_gke_nodepool" {
    provider = google-beta
    project = var.project_id
    name = var.nodepool_name
    location = var.region
    cluster = google_container_cluster.gke_cluster.name
    node_count = var.node_count

    node_config {
        image_type = var.image_type
        machine_type = var.machine_type
        disk_size_gb = var.disk_size_gb

        oauth_scopes = [ "https://www.googleapis.com/auth/cloud-platform" ]
        service_account = google_service_account.gke_node_pool_sa.email
        tags = [
            var.network_tag
        ]
        workload_metadata_config {
          node_metadata = "GKE_METADATA_SERVER"
        }
    }
    autoscaling {
        min_node_count = var.node_count
        max_node_count = var.max_node_count
    }
}