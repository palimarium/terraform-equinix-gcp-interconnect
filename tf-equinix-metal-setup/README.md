# Equinix Metal BMS

Basic Terraform module for creating a Equinix Metal Server and attach it to a VLAN.

This module will:
1. Create a Metal VLAN
2. Deploy a Metal instance in Hybrid Bonded mode
3. Attach the instance to the VLAN
4. Run script in User Data to configure the Metal network interface(s)



![GCP Equinix Metal diagram](../docs/images/DS-metalNE-diagram.png?raw=true "GCP Equinix Metal diagram")



# Usage

1. Use your text editor to set the required parameters inside [terraform.tfvars](terraform.tfvars).
   ```sh
   vim terraform.tfvars

2. From the [tf-equinix-metal-setup](./) directory execute terraform

   ```sh
   terraform init
   terraform plan
   terraform apply -auto-approve



---
Product Documentation:
- Equinix Metal:  https://metal.equinix.com/developers/docs/
