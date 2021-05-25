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
variable "zone_A" {
  description = "zone in which to manage GCP resources"
}
variable "zone_B" {
  description = "zone in which to manage GCP resources"
}
variable "zone_C" {
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
## Redis Vars
## ---------------------
variable "name" {
    type = string
}
variable "tier" {
    type = string
    default = "BASIC"
}

variable "network_name" {
    type = string
    default = "The name of the network to create to run cluster instances"
}