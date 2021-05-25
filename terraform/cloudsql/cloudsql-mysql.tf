## Cloud SQL instance

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "k_c_cloudsql_mysql" {
  provider = google-beta

  name = "mysql-an3-k-c-dev-${random_id.db_name_suffix.hex}"
  project = var.project_id
  database_version = "MYSQL_5_7"
  depends_on = [google_service_networking_connection.private_vpc_connection]

  # when using cloud_CMK
  # encryption_key_name = null

  settings {
    tier = var.machine_type
    activation_policy = "ALWAYS"
    availability_type = var.availability_type

    backup_configuration {
      binary_log_enabled = var.availability_type == "REGIONAL" ? true : false
      enabled = var.availability_type == "REGIONAL" ? true : false
      
      # Muli region or regional
      location = var.availability_type == "REGIONAL" ? var.region : null

      #UTC Tile
      start_time = var.availability_type == "REGIONAL" ? "20:00" : null
    }

    maintenance_window {
      # Day of week (1-7), starting on Monday
      day = "6"

      # Hour of the day (0-23), ignored if day net set / UTC time
      hour = "17"
      update_track = "stable"
    }

    # (Optional) Whether this Cloud SQL instance should be assigned a public IPV4 address.
    # Either ipv4_enabled must be enabled or a private_network must be configured.
    ip_configuration {
      ipv4_enabled = false 
      private_network = var.network_name
      # private_network = google_compute_network.private_network.id
      require_ssl = false
    }

    disk_autoresize = true
    disk_size = "10"
    disk_type = "PD_SSD"
    pricing_plan = "PER_USE"

    user_labels = null

    location_preference {
      follow_gae_application = null
      zone = var.zone
    }

    database_flags {
      name = "lower_case_table_names"
      value = "1"
    }
    database_flags {
      name = "transaction_isolation"
      value = "READ-COMMITTED"
    }
    database_flags {
      name = "slow_query_log"
      value = "1"
    }
    database_flags {
      name = "long_query_time"
      value = "5"
    }
    database_flags {
      name = "log_bin_trust_function_creators"
      value = "on"
    }
  }
}