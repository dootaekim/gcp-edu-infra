## ---------------------
## Common Vars
## ---------------------
zone                    =   "asia-northeast3-a"
gcs_folder_stage        =   "k-c-gke"
gcs_tfstate_file        =   "k-c-gke-dev"


## ---------------------
## Cluster Configuration
## ---------------------
cluster_name    =   "kc-cluser-dev"
network_name    =   "projects/knight-crawler-302215/global/networks/vpc-network"
subnet_name     =   "projects/knight-crawler-302215/regions/asia-northeast3/subnetworks/sbn-k-c-gke-dev"
cluster_description =   "k-c-cluster managed by terraform"
min_master_version  =   "1.17.14-gke.400"
master_ipv4_cidr_block  =   "10.178.18.16/28"
cluster_secondary_range_name    =   "sbn-an3-dev-geknode-pods"
services_secondary_range_name   =   "sbn-an3-dev-gkenode-svc"


## ---------------------
## Node Pool Configuration
## ---------------------
nodepool_name   =   "kc-np-dev"
node_count      =   1
machine_type    =   "e2-standard-4"
disk_size_gb    =   30
image_type      =   "COS"
max_node_count  =   10
network_tag     =   "sgtag-an3-kc-gke"