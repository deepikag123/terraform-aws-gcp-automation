resource "google_compute_instance" "vm_instance" {
  name         = "${var.project_name}-gcp-vm"
  machine_type = "e2-micro"
  zone         = "${var.gcp_region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    echo "Hello from GCP - Terraform by Deepika" > /var/www/html/index.html
  EOF

  tags = ["http-server", "https-server"]

  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# ADD THIS BELOW ↓↓↓
resource "google_compute_firewall" "allow_http" {
  name    = "${var.project_name}-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}
