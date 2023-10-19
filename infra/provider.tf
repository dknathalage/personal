provider "google" {
  project     = local.gcp_project
  region      = local.gcp_region
  credentials = var.gcp_credentials
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
  default     = ""
  description = "GCP Project ID"
}

variable "gcp_region" {
  default     = ""
  description = "GCP Region"
}

variable "gcp_credentials" {
  default     = ""
  description = "GCP Credentials"
}


