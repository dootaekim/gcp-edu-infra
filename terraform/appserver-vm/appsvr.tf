module "create_appsvr_instance" {
    source = "../0-modules/instance-with-image"
    instance_name   =   "vm-an3-k-c-appsvr"
    machine_type    =   "e2-standard-2"
    instance_zone   =   "asia-northeast3-a"
    instance_network_tags   =   [
        "tbd",
        "sgtag-deploysrc-allow"
    ]
    image_name      =   "ubuntu-os-cloud/ubuntu-1804-lts"
    instance_subnetwork =   "projects/knight-crawler-302215/regions/asia-northeast3/subnetworks/sbn-k-c"
    service_account     =   "knight-crawler-dev-svc@knight-crawler-302215.iam.gserviceaccount.com"
}