# Main VPC
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}



resource "google_compute_network" "vpc-gcp" {
  name                    = "vpc-gcp"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

