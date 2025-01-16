resource "google_service_account" "clouddeploy_service_account" {
  account_id = "clouddeploy-sa"
}

resource "google_project_iam_member" "assume_as" {
  project = "gcp-devops-436118"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.clouddeploy_service_account.email}"
}

resource "google_project_iam_member" "clouddeploy_jobrunner" {
  project = "gcp-devops-436118"
  role    = "roles/clouddeploy.jobRunner"
  member  = "serviceAccount:${google_service_account.clouddeploy_service_account.email}"
}
resource "google_project_iam_member" "clouddeploy_containerdev" {
  project = "gcp-devops-436118"
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.clouddeploy_service_account.email}"
}

resource "google_clouddeploy_target" "primary" {
  location = "us-central1"
  name     = "target"

#   deploy_parameters = {
#     deployParameterKey = "deployParameterValue"
#   }

  description = "This is the cluster for employee app"

  gke {
    cluster =  "projects/gcp-devops-436118/locations/us-central1/clusters/my-gke-cluster"
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
    depends_on = [ google_container_cluster.primary ]
}


resource "google_clouddeploy_delivery_pipeline" "primary" {
  location    = "us-west1"
  name        = "pipeline"
  description = "This delivery pipeline for employee application"
  project     = "gcp-devops-436118"

  serial_pipeline {
    stages {
    #  deploy_parameters {
    #     values = {
    #       deployParameterKey = "deployParameterValue"
    #     } 

        # match_target_labels = {}
    #   }

    #   profiles  = ["example-profile-one", "example-profile-two"]
      target_id = google_clouddeploy_target.primary.id
    }

     }

#   annotations = {
#     my_first_annotation = "example-annotation-1"

#     my_second_annotation = "example-annotation-2"
#   }

#   labels = {
#     my_first_label = "example-label-1"

#     my_second_label = "example-label-2"
#   }
#   provider    = google-beta
}
