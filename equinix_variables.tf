/*
 * Terraform variable declarations for Equinix Fabric.
 */

variable eqx_fabric_client_id {
  description = "Equinix Fabric Developer API client ID"
}

variable eqx_fabric_client_secret {
  description = "Equinix Fabric Developer API client Secret"
}

variable eqx_fabric_notification_users {
  type        = list(string)
  description = "A list of email addresses that would be notified when there are any updates on this connection"
}

variable eqx_fabric_gcp_primary_connection_name {
  description = "Equinix Fabric connection name for GCP"
}

variable eqx_fabric_gcp_speed {
  description = "speed for the NE connection, must be allowed by the platform and seller"
}

variable eqx_fabric_gcp_speed_unit {
  description = "MB / GB, must be allowed by the platform and the seller"
}

variable eqx_fabric_gcp_seller_region {
  description = "The region in which the seller port (GCP) resides"
}

variable eqx_fabric_gcp_seller_metro_code {
  description = "Seller metro to connect to"
}

/*
 * Terraform variable declarations for Equinx Network Edge.
 */
 
variable eqx_ne_device_id {
  description = "If you already have a Network Edge device created. Required if 'eqx_ne_create_ne_device' is 'false'"
}

variable eqx_ne_create_ne_device {
  description = "if true create a Network Edge device, if not skip and use the provided device id"
}

variable eqx_ne_account_number {
  description = "Billing account number for a device"
}

variable eqx_ne_device_name {
  description = "Equinix Network Edge device name"
}

variable eqx_ne_device_hostname {
  description = "Device hostname prefix"
}

variable eqx_ne_device_metro_code {
  description = "Device location metro code"
}

variable eqx_ne_device_package_code {
  description = "Device software package code"
}

variable eqx_ne_acl_template_name {
  description = "Name of the new ACL template to be attached to the NE device"
}

variable eqx_ne_device_term_length {
  type = number
  description = "Device term length"
}

variable eqx_ne_device_throughput {
  type = number
  description = "Device license throughput"
}

variable eqx_ne_device_throughput_unit {
  description = "License throughput unit (Mbps or Gbps)"
}

variable eqx_ne_device_interface_count {
  type = number
  description = "Number of network interfaces on a device. If not specified, default number for a given device type will be used"
}

variable eqx_ne_device_core_count {
  type = number
  description = "Number of CPU cores used by device"
}

variable eqx_ne_device_version {
  description = "Device software software version"
}

variable eqx_ne_ssh_user {
  description = "Device - SSH user login name"
}

variable eqx_ne_ssh_pwd {
  description = "Device - SSH user password"
}
