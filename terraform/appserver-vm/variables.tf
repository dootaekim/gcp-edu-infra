## ---------------------
## Provider configuration
## ---------------------
variable "project_id" {

}

variable "region" {

}

variable "zone" {

}

variable "environment" {
    type    =   string
}

variable "gcs_bucket" {
    type    =   string
}

variable "gcs_folder_project" {
    type    =   string
}

variable "gcs_tfstate_file" {
    type    =   string
}

variable "gcs_folder_stage" {
    type    =   string
}