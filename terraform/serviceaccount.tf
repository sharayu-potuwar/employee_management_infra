resource "google_service_account" "service_account" {
  account_id   = "sa-cloudsql-01"
  display_name = "sa-cloudsql-01"
}

resource "google_service_account" "service_account01" {
  account_id   = "sa-cloudbuild-01"
  display_name = "sa-cloudbuild-01"
}