### root password secrets ###
resource "google_secret_manager_secret" "db_root_password_secrets" {
  secret_id = "mysql_root_pw_secrets"
  project   = var.project_id
  replication {
      automatic = true
   }
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
}

resource "google_secret_manager_secret_version" "db_root_password_version" {
  secret      = google_secret_manager_secret.db_root_password_secrets.id
  secret_data = random_password.mysql_root_password.result
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
}


### app password secrets  ###
resource "google_secret_manager_secret" "db_app_password_secrets" {
  secret_id = "mysql_app_pw_secrets"
  project   = var.project_id
  replication {
      automatic = true
   }
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
}
resource "google_secret_manager_secret_version" "db_app_password_version" {
  secret      = google_secret_manager_secret.db_app_password_secrets.id
  secret_data = random_password.mysql_app_password.result
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
}

### reaonly user password secrets ###
resource "google_secret_manager_secret" "db_mgr_password_secrets" {
  secret_id = "mysql_mgr_pw_secrets"
  project   = var.project_id
  replication {
      automatic = true
   }
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
}
resource "google_secret_manager_secret_version" "db_mgr_password_version" {
  secret      = google_secret_manager_secret.db_mgr_password_secrets.id
  secret_data = random_password.mysql_mgr_password.result
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
}

# ### SSL Client Cert Key secrets ###
# resource "google_secret_manager_secret" "db_clientcert_key_secrets" {
#   secret_id = "mysql_clientcert_key_secrets"
#   project   = var.project_id
#   replication {
#       automatic = true
#    }
#   depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
# }
# resource "google_secret_manager_secret_version" "db_clientcert_key_version" {
#   secret      = google_secret_manager_secret.db_clientcert_key_secrets.id
#   secret_data = google_sql_ssl_cert.mysql_client_cert.private_key
#   depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
# }

### DB connection_name for other terraform use ###
resource "google_secret_manager_secret" "db_connection_name_secrets" {
  secret_id = "mysql_connection_name_secrets"
  project   = var.project_id
  replication {
      automatic = true
   }
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
}
resource "google_secret_manager_secret_version" "db_connection_name_version" {
  secret      = google_secret_manager_secret.db_connection_name_secrets.id
  secret_data = google_sql_database_instance.k_c_cloudsql_mysql.connection_name
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
}

### DB ip address for other terraform use ###
resource "google_secret_manager_secret" "db_ip_secrets" {
  secret_id = "mysql_ip_secrets"
  project   = var.project_id
  replication {
      automatic = true
   }
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]   
}
resource "google_secret_manager_secret_version" "db_ip_version" {
  secret      = google_secret_manager_secret.db_ip_secrets.id
  secret_data = google_sql_database_instance.k_c_cloudsql_mysql.ip_address.0.ip_address
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]  
}