module "create_jenkins_instance" {
    source = "../0-modules/instance-with-image"
    instance_name   =   "vm-an3-k-c-jenkins"
    machine_type    =   "e2-standard-2"
    instance_zone   =   "asia-northeast3-a"
    instance_network_tags   =   [
        "tbd"
    ]
    image_name      =   "centos-cloud/centos-7"
    instance_subnetwork =   "projects/knight-crawler-302215/regions/asia-northeast3/subnetworks/sbn-k-c"
    service_account     =   "knight-crawler-dev-svc@knight-crawler-302215.iam.gserviceaccount.com"
}