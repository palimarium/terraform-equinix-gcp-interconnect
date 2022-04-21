/*
 * Terraform Equinix Fabric resources for Equinix.
 */

//Retrieve GCP profile id
data "equinix_ecx_l2_sellerprofile" "gcp" {
  name = "Google Cloud Partner Interconnect Zone 1"
}

//Create ECX L2 connection
resource "equinix_ecx_l2_connection" "gcp" {
  name              = var.eqx_fabric_gcp_primary_connection_name
  profile_uuid      = data.equinix_ecx_l2_sellerprofile.gcp.uuid
  speed             = var.eqx_fabric_gcp_speed
  speed_unit        = var.eqx_fabric_gcp_speed_unit
  notifications     = var.eqx_fabric_notification_users
  device_uuid       = local.router_id
  seller_region     = var.eqx_fabric_gcp_seller_region
  seller_metro_code = var.eqx_fabric_gcp_seller_metro_code
  authorization_key = google_compute_interconnect_attachment.interconn-vlan.pairing_key // GCP Service Key
}
