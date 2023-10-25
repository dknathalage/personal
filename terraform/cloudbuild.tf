module "svc-front" {
  source         = "./modules/service-cloudbuild"
  name           = "front"
  namespace_name = kubernetes_namespace.namespace1.metadata[0].name
}
