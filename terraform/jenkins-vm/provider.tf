provider "google" {
    project     =   var.project_id
    region      =   var.region
    credentials =   file("../0-gcp-credentials/knight-crawler-dev-svc.json")
}

provider "google-beta" {
    project     =   var.project_id
    region      =   var.region
    credentials =   file("../0-gcp-credentials/knight-crawler-dev-svc.json")
}