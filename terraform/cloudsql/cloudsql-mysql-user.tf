### random root password ###
resource "random_password" "mysql_root_password" {
  length = 16
  special = true
  override_special = "_%@"
}
resource "google_sql_user" "mysql_root_user" {
  name       = "root"
  project    = var.project_id
  instance   = google_sql_database_instance.k_c_cloudsql_mysql.name
  host       = "%"
  password   = random_password.mysql_root_password.result  
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]
}
### random app password ###
resource "random_password" "mysql_app_password" {
  length = 16
  special = true
  override_special = "_%@"
}
resource "google_sql_user" "mysql_app_user" {
  name       = "crawler_app"
  project    = var.project_id
  instance   = google_sql_database_instance.k_c_cloudsql_mysql.name
  host       = "%"
  password   = "xlazla" 
  # password   = random_password.mysql_app_password.result 
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]
}
resource "random_password" "mysql_mgr_password" {
  length = 16
  special = true
  override_special = "_%@"
}
resource "google_sql_user" "mysql_mgr_user" {
  name       = "crawler_mgr"
  project    = var.project_id
  instance   = google_sql_database_instance.k_c_cloudsql_mysql.name
  host       = "%"
  password   = "xlazla" 
  # password   = random_password.mysql_readonly_password.result 
  depends_on  = [google_sql_database_instance.k_c_cloudsql_mysql]
}