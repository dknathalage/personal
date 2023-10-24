resource "google_cloudbuild_trigger" "build-trigger" {
  name        = "${var.name}-build-trigger"
  description = "Trigger for ${var.name} service"
  location    = "australia-southeast1"

  #   trigger_template {
  #     branch_name = "main"
  #     project_id  = var.gcp_project
  #     dir         = "services/${var.name}"
  #     # repo_name   = var.gcp_repo
  #   }

  github {
    owner = "Kushan-Nilanga"
    name  = "personal"
    push {
      branch = "main"
    }
  }

  included_files = [
    "services/${var.name}/**",
    "services/${var.name}/Dockerfile"
  ]

  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", "australia-southeast1-docker.pkg.dev/${var.gcp_project}/personal-workload-images/${var.name}:$COMMIT_SHA", "-f", "services/${var.name}/Dockerfile", "."]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["push", "australia-southeast1-docker.pkg.dev/${var.gcp_project}/personal-workload-images/${var.name}:$COMMIT_SHA"]
    }
  }
}

variable "name" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "gcp_repo" {
  type = string
}
