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
      args = ["build", "-t", "australia-southeast1-docker.pkg.dev/$PROJECT_ID/personal-workload-images/${var.name}:$COMMIT_SHA", "."]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      dir  = "services/${var.name}"
      args = ["push", "australia-southeast1-docker.pkg.dev/$PROJECT_ID/personal-workload-images/${var.name}:$COMMIT_SHA"]
    }
    step {
      # use helm to reploy
      name = "australia-southeast1-docker.pkg.dev/$PROJECT_ID/personal-workload-images/helm"
      args = [
        "upgrade",
        "--install", "${var.name}", "./config/service",
        "--values", "./config/${var.name}.yaml",
        "--namespace", "${var.namespace_name}",
        "--set", "image.tag=$COMMIT_SHA"
      ]
      env = [
        "KUBECONFIG=/workspace/.kube/config",
        "CLOUDSDK_COMPUTE_ZONE=australia-southeast1-a",
        "CLOUDSDK_CONTAINER_CLUSTER=workload-cluster",
      ]
    }
  }
}

variable "name" {
  type = string
}

variable "namespace_name" {
  type = string
}
