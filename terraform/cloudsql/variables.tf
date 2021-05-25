## ---------------------
## Provider configuration
## ---------------------

variable "project_id" {
  description = "Project ID in GCP"
}
variable "region" {
  description = "Region in which to manage GCP resources"
}
variable "zone" {
  description = "zone in which to manage GCP resources"
}
variable "environment" {
    type = string
}
variable "gcs_bucket" {
    type = string
}
variable "gcs_folder_project" {
    type = string
}
variable "gcs_tfstate_file" {
    type = string
}
variable "gcs_folder_stage" {
    type = string
}


## ---------------------
## Cloudsql Vars
## ---------------------
variable "machine_type" {
    default = "Cloud SQL Instance Machine Type"
}
variable "availability_type" {
    default = "The availability type of Cloud SQL insance, HA (REGIONAL) or single zone (ZONAL) "
}
variable "network_name" {
    type = string
    default = "The name of the network to create to run cluster instances"
}