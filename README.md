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

![terraform apply equinix edge](/docs/images/terraform-apply-equinix-edge.png?raw=true "terraform apply equinix edge")   

## B) Setup Equinix Metal

1. Enter [tf-equinix-metal-setup](/tf-equinix-metal-setup/) directory and use your text editor to set the required parameters.

   ```sh
   cd tf-equinix-metal-setup
   vim terraform.tfvars

2. From the [tf-equinix-metal-setup](/tf-equinix-metal-setup/) directory execute terraform

   ```sh
   terraform init
   terraform plan
   terraform apply -auto-approve

![terraform apply equinix metal](/docs/images/terraform-apply-equinix-metal.png?raw=true "terraform apply equinix metal")


## C) Setting Up a Shared Port

Setting up a shared port has two components:

1. Completing the request in the Equinix Metal console

To request a connection in the [Equinix Metal portal](https://metal.equinix.com/developers/docs/equinix-interconnect/shared-ports/#requesting-a-connection), open the Connections page from the IPs & Networks tab.

![request connection](/docs/images/l2-connection-request.png?raw=true "request connection")

2. Setting up the connection in Equinix Fabric

Connections to Equinix Metal shared ports are handled through Equinix Fabric, so log in to the [Equinix Fabric portal](https://fabric.equinix.com/) and follow the [documentation steps](https://metal.equinix.com/developers/docs/equinix-interconnect/shared-ports/#connecting-through-equinix-fabric)

### Connecting the Metal VLAN to the Shared Port

Once the L2 connection is ready, between Equinix Metal and Equinix Fabric, you can [follow these steps](https://metal.equinix.com/developers/docs/equinix-interconnect/shared-ports/#connecting-vlans-to-shared-ports) for connecting the Primary Port to the Metal VLAN [created by terraform](/tf-equinix-metal-setup/main.tf#L18) at the previous step b).


## D) Equinix Metal to Equinix Fabric,Layer2 & BGP Configuration


1. Connect to Cisco CSR NE with [Putty](https://www.putty.org/) by using the ssh username & password, [generated with terraform](equinix_ne.tf#L29)   

![putty equinix ne](/docs/images/putty-equinix-ne.png?raw=true "putty equinix ne")

2. In this step we will configure a basic Layer 2 connection between Network Edge and Equinix Metal. The sub-interface on the Metal server with the IP address *172.16.0.100* has been already [created by terraform](/tf-equinix-metal-setup/templates/user_data.sh.tpl), we just have to proceed with the *Network Edge Configuration* by following the steps from [here](https://docs.equinix.com/en-us/Content/digital-config/DC-metal-NE-Layer2.htm). 