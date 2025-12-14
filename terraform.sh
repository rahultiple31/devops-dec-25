#!/bin/bash

set -e

WORKSPACE=$1

if [[ -z "$WORKSPACE" ]]; then
  echo "Usage: $0 {dev|nprod|prod}"
  exit 1
fi

TFVARS_FILE="${WORKSPACE}.tfvars"

terraform init


terraform workspace select "$WORKSPACE"


terraform plan -var-file="$TFVARS_FILE"


terraform apply -var-file="$TFVARS_FILE"
