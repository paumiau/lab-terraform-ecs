output "workspace_info" {
  value = {
    workspace   = terraform.workspace
    environment = var.environment
    name_prefix = local.name_prefix
  }
}
