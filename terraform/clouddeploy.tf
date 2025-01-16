resource "google_service_account" "clouddeploy_service_account" {
  account_id = "clouddeploy-sa"
}

resource "google_project_iam_member" "assume_as" {
  project = "gcp-devops-436118"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.clouddeploy_service_account.email}"
}

resource "google_clouddeploy_target" "primary" {
  location = "us-central1"
  name     = "target"

  deploy_parameters = {
    deployParameterKey = "deployParameterValue"
  }

  description = "This is the cluster for employee app"

  gke {
    cluster =  google_container_cluster.primary.name
  }

  project          = "gcp-devops-436118"
  require_approval = true
  
  execution_configs {
    usages            = ["RENDER", "DEPLOY"]
    service_account = google_service_account.clouddeploy_service_account.id
  }
#   annotations = {
#     my_first_annotation = "example-annotation-1"

#     my_second_annotation = "example-annotation-2"
#   }

#   labels = {
#     my_first_label = "example-label-1"

#     my_second_label = "example-label-2"
#   }
}

