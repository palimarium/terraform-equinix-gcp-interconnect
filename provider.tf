/*
 * Terraform provider definitions
 */

terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.5.0"
    }
    google = {
      source = "hashicorp/google"
      version = "~> 4.17.0"
    }
    time = "~> 0.6.0"
  }
}

provider "equinix" {
  client_id       = var.eqx_fabric_client_id
  client_secret   = var.eqx_fabric_client_secret
  request_timeout = 60
}
/*
provider "google" {
  alias = "impersonation_tokengen"
}

# get config of the client that runs
data "google_client_config" "default" {
  provider = google.impersonation_tokengen

}

data "google_service_account_access_token" "sa" {
  provider               = google.impersonation_tokengen
  target_service_account = "terraform-runner@${var.gcp_project_id}.iam.gserviceaccount.com"
  lifetime               = "1800s"
  scopes                 = ["userinfo.email","cloud-platform","iam"]
}
*/

/******************************************
  GA Provider configuration
 *****************************************/
provider "google" {
#access_token = data.google_service_account_access_token.sa.access_token
  credentials = file("/home/marius/Downloads/equinix-gcp-demo-3046aa310856.json")
  project     = var.gcp_project_id
  region      = var.gcp_region
  scopes       = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
   "https://www.googleapis.com/auth/iam",
  ]
}
