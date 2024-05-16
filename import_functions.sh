#!/bin/bash

PROJECT_ID="aafes-poc-378616"
REGION="us-central1"


func_list="aafes-abandon-cart-qa aafes-subscriptions-qa aafes-subscriptions aafes-abandon-cart"

# FUNCTIONS=$(gcloud functions list --project="$PROJECT_ID" --format="value(name)")
# for FUNCTION in "${FUNCTIONS[@]}"; do

provider_file_path="provider.tf"
main_file_path="main.tf"

if [ ! -f "$provider_file_path" ]; then
cat <<EOF > $provider_file_path
provider "google" {
  project = "$PROJECT_ID"
  region  = "$REGION"
  credentials = file("$credentials")
}
EOF
fi

if [ ! -f "$main_file_path" ]; then
    touch $main_file_path
fi

final_func_list=""

for FUNCTION in $func_list; do
    a=$(sed -n 's/.*"\('"$FUNCTION"'\)".*/\1/p' $main_file_path)
    if [ -z "$a" ]; then
        final_func_list="$final_func_list $FUNCTION"
    fi
done

for func_resources in $final_func_list; do
echo '
resource "google_cloudfunctions_function" "'${func_resources}'" {
}' >> $main_file_path
done

terraform init

for import_func in $final_func_list; do
    terraform import google_cloudfunctions_function.$import_func projects/$PROJECT_ID/locations/$REGION/functions/$import_func
done
