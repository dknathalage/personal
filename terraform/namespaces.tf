resource "kubernetes_namespace" "namespace1" {
  metadata {
    annotations = { "env" = "prod" }
    labels      = { "env" = "prod" }
    name        = "namespace1"
  }
}
