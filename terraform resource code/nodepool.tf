
# Node-pool
resource "google_container_node_pool" "nodepool" {
  name       = "nodepool"
  cluster    = google_container_cluster.primary.id
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "nodepool"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

