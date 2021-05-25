## ---------------------
## Common Vars
## ---------------------
zone                    =   "asia-northeast3-a"
gcs_folder_stage        =   "k-c-cloudsql"
gcs_tfstate_file        =   "k-c-cloudsql-dev"

## ---------------------
## Cloudsql Vars
## ---------------------

machine_type            =   "db-n1-standard-1"
availability_type       =   "ZONAL"
network_name            =   "projects/knight-crawler-302215/global/networks/vpc-network"