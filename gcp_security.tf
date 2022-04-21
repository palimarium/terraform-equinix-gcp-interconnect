/*
 * Terraform security resources for GCP.
 */

# Allow PING testing.
resource "google_compute_firewall" "gcp-allow-icmp" {
 name    = "${google_compute_network.gcp-network.name}-gcp-allow-icmp"
 network = google_compute_network.gcp-network.name

 allow {
   protocol = "icmp"
 }

 source_ranges = [
   "0.0.0.0/0",
 ]
}

# Allow SSH for testing.
resource "google_compute_firewall" "gcp-allow-ssh" {
 name    = "${google_compute_network.gcp-network.name}-gcp-allow-ssh"
 network = google_compute_network.gcp-network.name

 allow {
   protocol = "tcp"
   ports    = ["22"]
 }

 source_ranges = [
   "0.0.0.0/0",
 ]
}

