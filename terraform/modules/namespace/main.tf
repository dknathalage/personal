resource "kubernetes_namespace" "ns" {
  metadata {
    annotations = var.annotations
    labels      = var.labels
    name        = var.name
  }
}

output "name" {
  value = kubernetes_namespace.ns.metadata[0].name
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
