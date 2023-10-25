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
      name = "gcr.io/$PROJECT_ID/helm"
      dir  = "services/${var.name}"
      args = [
        "upgrade",
        "--install", "${var.name}", "/config/service",
        "--values", "service.yaml",
        "--namespace", "${var.namespace_name}",
        "--set", "image.tag=$COMMIT_SHA"
      ]
      env = [
        "KUBECONFIG=/workspace/.kube/config",
        "CLOUDSDK_COMPUTE_REGION=australia-southeast1",
        "CLOUDSDK_COMPUTE_ZONE=australia-southeast1-a",
        "CLOUDSDK_CONTAINER_CLUSTER=workload-cluster",
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
