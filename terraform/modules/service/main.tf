resource "google_cloudbuild_trigger" "build-trigger" {
  name        = "${var.name}-build-trigger"
  description = "Trigger for ${var.name} service"
  location    = "australia-southeast1"

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
      dir  = "services/${var.name}"
      args = ["build", "-t", "australia-southeast1-docker.pkg.dev/${var.gcp_project}/personal-workload-images/${var.name}:$COMMIT_SHA", "."]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      dir  = "services/${var.name}"
      args = ["push", "australia-southeast1-docker.pkg.dev/${var.gcp_project}/personal-workload-images/${var.name}:$COMMIT_SHA"]
    }
    step {
      # use helm to reploy
      name = "gcr.io/cloud-builders-community/helm"
      dir  = "services/${var.name}"
      args = [
        "upgrade",
        "--install", "${var.name}", "../../../config/service",
        "--namespace", "${var.namespace_name}",
        "--set", "image.tag=$COMMIT_SHA"
      ]
    }
  }
}

variable "name" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "namespace_name" {
  type = string
}
