module "namespace1" {
  source      = "./modules/namespace"
  name        = "namespace1"
  labels      = { "env" = "prod" }
  annotations = { "env" = "prod" }
}
