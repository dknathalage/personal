provider "google" {
  project = local.gcp_project
  region  = "australia-southeast1"
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.default.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.provider.access_token
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
  backend "gcs" {
    bucket = "workload-bucket-personal"
    prefix = "terraform/state"
  }
}

