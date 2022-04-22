terraform {
  required_providers {
    metal = {
      source  = "equinix/metal"
      version = ">= 3"
    }
    equinix = {
      source = "equinix/equinix"
    }
  }
}

provider "metal" {
  auth_token = var.auth_token
}


resource "metal_vlan" "vlan1" {
  metro       = var.metro
  project_id  = var.project_id
  description = var.metal_vlan_description
  vxlan       = var.metal_vxlan
}

#Deploy Metal Intance
resource "metal_device" "node" {
  count = var.metal_node_count

  hostname         = var.hostname
  plan             = var.plan
  metro            = var.metro
  operating_system = var.operating_system
  billing_cycle    = var.billing_cycle
  project_id       = var.project_id
  user_data = templatefile("${path.module}/templates/user_data.sh.tpl", {
    LAST_OCTET  = count.index + 5
    METAL_VXLAN = var.metal_vxlan
  })
}

#Set Metal instance to Hybrid Bonded network mode
resource "metal_device_network_type" "node" {
  count = var.metal_node_count

  device_id = metal_device.node[count.index].id
  type      = var.metal_network_mode
}

#attach instance to Metal VLAN1
resource "metal_port_vlan_attachment" "router_vlan_attach" {
  count = var.metal_node_count

  device_id = metal_device.node[count.index].id
  port_name = var.port_name
  vlan_vnid = metal_vlan.vlan1.vxlan
}


#associate Metal VLAN1 to Primary Port of the shared Connection to Fabric Edge L2
#right now works only for dedicated ports 
# "https://registry.terraform.io/providers/equinix/metal/latest/docs/resources/virtual_circuit"
# FR open: "https://github.com/equinix/terraform-provider-metal/issues/150"
