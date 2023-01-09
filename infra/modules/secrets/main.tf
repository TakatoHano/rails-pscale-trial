module "secret" {
  source = "./secret"
  for_each = var.secrets

  project_id = var.project_id
  secret_id = each.key
  data = each.value
}
