/*
 * Terraform Network Edge resources for Equinix.
 */
data "equinix_network_device_type" "router" {
  name = "CSR 1000V"
}

resource "equinix_network_device" "router" {
  count             = var.eqx_ne_create_ne_device ? 1 : 0

  name              = var.eqx_ne_device_name
  type_code         = data.equinix_network_device_type.router.code
  hostname          = var.eqx_ne_device_hostname
  byol              = false
  metro_code        = var.eqx_ne_device_metro_code
  notifications     = var.eqx_fabric_notification_users
  package_code      = var.eqx_ne_device_package_code
  term_length       = var.eqx_ne_device_term_length
  throughput        = var.eqx_ne_device_throughput
  throughput_unit   = var.eqx_ne_device_throughput_unit
  account_number    = var.eqx_ne_account_number
  interface_count   = var.eqx_ne_device_interface_count
  core_count        = var.eqx_ne_device_core_count
  version           = var.eqx_ne_device_version
  acl_template_id   = equinix_network_acl_template.acl.id
  self_managed      = false
}

locals {
  router_id = var.eqx_ne_create_ne_device ? equinix_network_device.router[0].id : var.eqx_ne_device_id
}

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}


resource "equinix_network_acl_template" "acl" {
  name        = var.eqx_ne_acl_template_name
  description = "Configure device automatically"

  inbound_rule {
    subnets  = ["${data.external.myipaddr.result.ip}/32"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_bgp" "gcp" {
  connection_id      = equinix_ecx_l2_connection.gcp.id
  local_ip_address   = local.gcp_bgp_equinix_side_address
  local_asn          = var.gcp_bgp_equinix_side_asn
  remote_ip_address  = cidrhost(local.gcp_bgp_cloud_address,1)
  remote_asn         = 16550 // The Cloud Router used by PARTNER type interconnect attachments must be assigned a local ASN of '16550'
}
