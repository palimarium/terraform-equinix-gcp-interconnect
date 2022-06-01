/*
* Terraform compute resources for GCP.
*/

data "google_compute_zones" "available" {
 region = var.gcp_region
}

resource "google_compute_address" "gcp-ip" {
 name   = format("%s-vm-ip", lower(var.project_name))
 region = var.gcp_region
}

resource "google_compute_instance" "gcp-vm" {
 name         = format("%s-vm", lower(var.project_name))
 machine_type = var.gcp_instance_type
 zone         = data.google_compute_zones.available.names[1]

 boot_disk {
   initialize_params {
     image = var.gcp_disk_image
   }
 }

 network_interface {
   subnetwork = google_compute_subnetwork.gcp-subnet-1.name
   network_ip = var.gcp_vm_address

   access_config {
     nat_ip = google_compute_address.gcp-ip.address
   }
 }
 
}
