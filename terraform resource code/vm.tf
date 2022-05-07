resource "google_compute_instance" "instance5" {
  name         = "instance5"
  machine_type = "e2-small"
  zone         = "us-central1-a"


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "10"
    }
  }

  network_interface {
    network = google_compute_network.vpc-gcp.id
    subnetwork = google_compute_subnetwork.management-subnet.id

    # access_config {
    #   // Ephemeral public IP
    # }
  }


  service_account {
    email  = google_service_account.kubernetes.email
    scopes = ["cloud-platform"]
  }
}