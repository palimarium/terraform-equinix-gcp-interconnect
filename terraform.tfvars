project_name    = "Equinix-Demo"
owner           = "Me"

// GCP variables
gcp_project_id              = "" //Google Cloud existing project ID Ex. "my-project"
gcp_subnet1_cidr            = "10.200.0.0/24"
gcp_vm_address              = "10.200.0.100"
gcp_region                  = "europe-west3"
gcp_instance_type           = "e2-medium"
gcp_disk_image              = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts"
gcp_bgp_equinix_side_asn    = 64538

// Equinix variables
eqx_fabric_notification_users   = [""] //["example@equinix.com"]
eqx_fabric_client_id            = "" //Equinix Fabric Consumer Key (API credentials from https://developer.equinix.com/)
eqx_fabric_client_secret        = "" //Equinix Fabric Consumer Secret (API credentials from https://developer.equinix.com/)

// GCP connection
eqx_fabric_gcp_primary_connection_name  = "DEMO_EF_GCP"
eqx_fabric_gcp_seller_region            = "europe-west3"
eqx_fabric_gcp_seller_metro_code        = "FR"
eqx_fabric_gcp_speed                    = "100"
eqx_fabric_gcp_speed_unit               = "MB"

// NE Device
eqx_ne_device_name              = "fabric-edge01"
eqx_ne_device_hostname          = "router01"
eqx_ne_device_metro_code        = "FR"
eqx_ne_device_package_code      = "SEC"
eqx_ne_device_term_length       = 1
eqx_ne_device_throughput        = 500
eqx_ne_device_throughput_unit   = "Mbps"
eqx_ne_account_number           = "155225"
eqx_ne_device_interface_count   = 10
eqx_ne_device_core_count        = 2
eqx_ne_device_version           = "16.12.03"
eqx_ne_create_ne_device         = true
eqx_ne_device_id                = "" //Required if eqx_ne_create_ne_device is false
eqx_ne_acl_template_name        = "allowmypublicIP"
eqx_ne_ssh_user                 = "eqxnessh2794" //leave it empty "" if eqx_ne_create_ne_device false
eqx_ne_ssh_pwd                  = "myuser223" //leave it empty "" if eqx_ne_create_ne_device false
