# service account for instance
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

# role to access cluster and container
resource "google_project_iam_binding" "Cluster"{
    project = "iti-project-348511"
    role = "roles/container.admin"
    members=[
      "serviceAccount:kubernetes@iti-project-348511.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.kubernetes]
}

# role to access  container registory storage
resource "google_project_iam_binding" "storage"{
    project = "iti-project-348511"
    role = "roles/storage.admin"
    members=[
      "serviceAccount:kubernetes@iti-project-348511.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.kubernetes]
}