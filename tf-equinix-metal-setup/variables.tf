variable "auth_token" {
  description = "Metal personal API Key"
  type        = string
}

variable "project_id" {
  description = "Metal Project ID"
  type        = string
}

variable "metro" {
  description = "Equinix Metal metro code"
  type        = string
  default     = "am"
}

variable "metal_vlan_description" {
  description = "Metal vlan description"
  type        = string
  default     = "vlan1"
}

variable "metal_vxlan" {
  description = "Metal vlan id"
  type        = number
  default     = 1000
}

variable "hostname" {
  description = "Metal instance hostname"
  type        = string
  default     = "testhost-01"
}

variable "plan" {
  description = "instance size/plan"
  type        = string
  default     = "c3.small.x86"
}

variable "operating_system" {
  description = "metal operating system"
  type        = string
  default     = "centos_7"
}

variable "billing_cycle" {
  description = "billing cycle"
  type        = string
  default     = "hourly"
}

variable "metal_network_mode" {
  description = "metal network mode"
  type        = string
  default     = "hybrid-bonded"
}

variable "metal_node_count" {
  description = "metal device count"
  type        = number
  default     = 1
}

variable "port_name" {
  description = "vlan attachment port name"
  type        = string
  default     = "bond0"
}
