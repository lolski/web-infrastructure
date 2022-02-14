terraform {
  backend "gcs" {
    bucket  = "vaticle-engineers-terraform-state"
    prefix  = "terraform/vault"
  }
}

provider "google" {
  project = "vaticle-engineers"
  region  = "europe-west2"
  zone    = "europe-west2-b"
}

resource "google_compute_firewall" "vault_api_firewall" {
  name    = "vault-api-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8200"]
  }

  source_tags = ["nomad-server", "nomad-client"]
  target_tags = ["vault"]
}

resource "google_compute_address" "vault_static_ip" {
  name = "vault-static-ip"
}

resource "google_compute_disk" "vault_additional" {
  name  = "vault-additional"
  type  = "pd-ssd"
}

resource "google_compute_instance" "vault" {
  name                      = "vault"
  machine_type              = "n1-standard-2"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "vaticle-engineers/vault-c0e79363f2ad60058abfd037ee3065c4e9e096ef"
    }
    device_name = "boot"
  }

  attached_disk {
    source = google_compute_disk.vault_additional.name
    device_name = "vault-additional"
  }

  service_account {
    email = "grabl-temporary2@vaticle-engineers.iam.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.vault_static_ip.address
    }
  }

  tags = ["vault"]

  metadata_startup_script = file("${path.module}/startup/startup-vault.sh")
}
