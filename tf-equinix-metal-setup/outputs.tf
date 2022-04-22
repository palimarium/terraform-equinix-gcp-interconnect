output "Public_IP" {
  value = metal_device.node.*.access_public_ipv4
}
