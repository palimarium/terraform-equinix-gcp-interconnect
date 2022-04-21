#!/bin/bash
# Author/Source code:https://blog.chy.la/posts/using-service-account-impersonation-with-terraform/ 

PROJECT_ID=$(gcloud config get-value project)

## Create terraform runner account
SERVICE_ACCOUNT_NAME_HIGH_PRIV="terraform-runner"

SERVICE_ACCOUNT_ID_HIGH_PRIV="$SERVICE_ACCOUNT_NAME_HIGH_PRIV@$PROJECT_ID.iam.gserviceaccount.com"

function create_service_account () {
  gcloud iam service-accounts create $1 \
    --description="Account used by Terraform to deploy IaC" \
    --display-name="$1"
}

echo "creating $SERVICE_ACCOUNT_ID_HIGH_PRIV service account"
create_service_account $SERVICE_ACCOUNT_NAME_HIGH_PRIV

## role/editor for testing, this can be adjusted as necessary
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$SERVICE_ACCOUNT_ID_HIGH_PRIV --role roles/editor

# Enable IAM credentials API for impersonation
gcloud services enable iamcredentials.googleapis.com

# GCE runner account binding permission to allow impersonation of the terraform-runner account
SERVICE_ACCOUNT_NAME_LOW_PRIV="terraform-doorman"

SERVICE_ACCOUNT_ID_LOW_PRIV="$SERVICE_ACCOUNT_NAME_LOW_PRIV@$PROJECT_ID.iam.gserviceaccount.com"

echo "creating $SERVICE_ACCOUNT_ID_LOW_PRIV service account"
create_service_account $SERVICE_ACCOUNT_NAME_LOW_PRIV

echo "Allow $SERVICE_ACCOUNT_ID_LOW_PRIV to generate a token for $SERVICE_ACCOUNT_NAME_HIGH_PRIV account"
gcloud iam service-accounts add-iam-policy-binding \
    $SERVICE_ACCOUNT_ID_HIGH_PRIV \
    --member=serviceAccount:$SERVICE_ACCOUNT_ID_LOW_PRIV \
    --role=roles/iam.serviceAccountTokenCreator
