module "svc-front" {
  source      = "./modules/service"
  name        = "svc-front"
  gcp_project = local.gcp_project
}
