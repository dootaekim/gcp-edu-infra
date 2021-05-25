#!/bin/sh

# Get directory we are running from
DIR=$(pwd)
COMMONFILE="$DIR/$1"
STAGEFILE="$DIR/$2"

if [ ! -f "$COMMONFILE" ]; then
   echo "Configuration file not found: $COMMONFILE"
   return 1
fi

if [ ! -f "$STAGEFILE" ]; then
   echo "Configuration file not found: $STAGEFILE"
   return 1
fi


ENVIRONMENT=$(grep environment "$COMMONFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
GCSBUCKET=$(grep gcs_bucket  "$COMMONFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
PROJECTID=$(grep project_id  "$COMMONFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
GCSBUCKETREGION=$(grep region "$COMMONFILE" | grep -v "/" |awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
GCSFOLDERPROJ=$(grep gcs_folder_project "$COMMONFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')

GCSFOLDERSTAGE=$(grep gcs_folder_stage "$STAGEFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')
GCSTFSTATEFILE=$(grep gcs_tfstate_file "$STAGEFILE" | awk -F '=' '{print $2}' | sed -e 's/["\ ]//g')

if [ -z "$ENVIRONMENT" ]
then
   echo "setenv: 'environment' variable not set in configuration file."
   return 1
fi
if [ -z "$GCSBUCKET" ]
then
   echo "setenv: 'gcs_bucket' variable not set in configuration file."
   return 1
fi
if [ -z "$PROJECTID" ]
then
   echo "setenv: 'project_id' variable not set in configuration file."
   return 1
fi
if [ -z "$GCSFOLDERPROJ" ]
then
   echo "setenv: 'gcs_folder_project' variable not set in configuration file."
   return 1
fi
if [ -z "$GCSBUCKETREGION" ]
then
   echo "setenv: 'region' variable not set in configuration file."
   return 1
fi
if [ -z "$GCSFOLDERSTAGE" ]
then
   echo "setenv: 'gcs_tfstate_file' variable not set in configuration file."
   echo "e.g. gcs_folder_stage=\"infrastructure.tfstate\""
   return 1
fi
if [ -z "$GCSTFSTATEFILE" ]
then
   echo "setenv: 'gcs_tfstate_file' variable not set in configuration file."
   echo "e.g. gcs_tfstate_file=\"infrastructure.tfstate\""
   return 1
fi

cat << EOF > "$DIR/backend.tf"
terraform {
   backend "gcs" {
       bucket = "${GCSBUCKET}-${PROJECTID}"
       prefix = "${GCSBUCKETREGION}/${ENVIRONMENT}/${GCSFOLDERPROJ}/${GCSFOLDERSTAGE}"
   }
}
EOF

export TF_WARN_OUTPUT_ERRORS=1
rm -rf "$DIR/.terraform"

cd "$DIR"
cat $DIR/backend.tf
echo "setenv: Initializing terraform"
terraform init > /dev/null

checkWorkspace=`terraform workspace list | grep $GCSTFSTATEFILE | wc -l`

if [ $checkWorkspace -eq 0 ]
then
   terraform workspace new $GCSTFSTATEFILE
else
   terraform workspace select $GCSTFSTATEFILE
fi