provider "google" {
  project = local.gcp_project
  region  = local.gcp_region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

locals {
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
}

variable "gcp_project" {
  default = ""
}

variable "gcp_region" {
  default = ""
}




