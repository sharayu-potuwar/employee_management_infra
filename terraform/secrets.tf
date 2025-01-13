resource "google_secret_manager_secret" "secret-with-version-destroy-ttl" {
  secret_id = "secret"

  version_destroy_ttl = "2592000s"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "member" {
  project = google_secret_manager_secret.secret-with-version-destroy-ttl.project
  secret_id = google_secret_manager_secret.secret-with-version-destroy-ttl.secret_id
  role = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.service_account.email}"
}