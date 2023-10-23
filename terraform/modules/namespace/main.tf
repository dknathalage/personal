resource "kubernetes_namespace" "example" {
  metadata {
    annotations = var.annotations
    labels      = var.labels
    name        = var.name
  }
}

variable "name" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "annotations" {
  type    = map(string)
  default = {}
}
