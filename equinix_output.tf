/*
 * Terraform output variables for Equinix.
 */

output "equinix_fabric_l2_gcp_connection_id" {
  value = equinix_ecx_l2_connection.gcp.id
}

output "equinix_network_device_type_code" {
  value = data.equinix_network_device_type.router.code
}
