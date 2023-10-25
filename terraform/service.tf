module "svc-front" {
  source         = "./modules/service"
  name           = "front"
  namespace_name = module.namespace1.name
}
