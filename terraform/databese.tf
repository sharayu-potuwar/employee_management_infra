resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "POSTGRES_15"
  region           = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
  deletion_protection=false
}

resource "google_project_iam_member" "cloudsql-sa-member" {
  project = "gcp-devops-436118"
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}