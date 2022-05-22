# terraform-equinix-gcp-interconnect

This lab aims to demonstrate how using the terraform Equinix provider, in conjunction with the Equinix Metal and Google provider, so you can fully automate the entire process of establishing a secure, direct connection between an Equinix bare metal server and Google Cloud.

After completing the lab you will be able to communicate from an virtual machine in GCP (GCE instance) to a bare metal server in Equinix BMaaS Platform, using private addressing.

![GCP Equinix Fabric diagram](/docs/images/architecture-diagram-equinix-gcp.png?raw=true "GCP Equinix Fabric diagram")


---

## Requirements

* Equinix Fabric Account:
  - Permission to create Connection and Network Edge devices
  - Generate Client ID and Client Secret key, from: https://developer.equinix.com/
* Equinix Metal Account:
  - A user-level API key for the Equinix Metal API  
* GCP Account: 
  - Permission to create a project or select one already created
  - Enable billing.
  - Enable APIs: Compute Engine API, and Cloud Deployment Manager API.



## Setup

Required steps to setup your environment for the lab:

* Install and setup Google Cloud SDK [Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install). Skip this step if you are using Google cloud shell.
* Install [jq for Linux](https://stedolan.github.io/jq/). Skip this step if you are using Google cloud shell.
* [generate a least priviledge Service Account](/tf-service-acccount-chain-setup.sh) for Impersonation with Terraform

# Usage

## A) Setup Equinix Network Edge Virtual Device

1. Clone this project

   ```sh
   mkdir -p $HOME/Workspace/demo-gcp-interconnect; cd $HOME/Workspace/demo-gcp-interconnect
   git clone https://github.com/palimarium/terraform-equinix-gcp-interconnect.git
   ```
2. Enter TF directory and use your text editor to set the required parameters. Only the ones with no default value are necessary, the others can be left as is.

   ```sh
   cd terraform-equinix-gcp-interconnect
   vim terraform.tfvars

3. Create terraform-runner GCP Service Account 
    ```sh
   ./tf-service-acccount-chain-setup.sh

![terraform runner SA](/docs/images/execute_tf-service-acccount-chain-setup.png?raw=true "terraform runner SA")

4. From the TF directory execute terraform

   ```sh
   terraform init
   terraform plan
   terraform apply -auto-approve

## B) Setup Equinix Metal

1. Enter [tf-equinix-metal-setup](/tf-equinix-metal-setup/) directory and use your text editor to set the required parameters. Only the ones with no default value are necessary, the others can be left as is.

   ```sh
   cd tf-equinix-metal-setup
   vim terraform.tfvars

2. From the [tf-equinix-metal-setup](/tf-equinix-metal-setup/) directory execute terraform

   ```sh
   terraform init
   terraform plan
   terraform apply -auto-approve

## C) Equinix Metal to Equinix Fabric, BGP Configuration



