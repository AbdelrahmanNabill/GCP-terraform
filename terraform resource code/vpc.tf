# Main VPC
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_dependent_services = true 
  disable_on_destroy         = true 
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_dependent_services = true 
  disable_on_destroy         = true 
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

