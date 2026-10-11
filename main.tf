resource "mongodbatlas_privatelink_endpoint_service" "privatelink_endpoint_services" {
  for_each = var.privatelink_endpoint_services

  endpoint_service_id         = each.value.endpoint_service_id
  private_link_id             = each.value.private_link_id
  project_id                  = each.value.project_id
  provider_name               = each.value.provider_name
  delete_on_create_timeout    = each.value.delete_on_create_timeout
  gcp_project_id              = each.value.gcp_project_id
  private_endpoint_ip_address = each.value.private_endpoint_ip_address

  dynamic "endpoints" {
    for_each = each.value.endpoints != null ? each.value.endpoints : []
    content {
      endpoint_name = endpoints.value.endpoint_name
      ip_address    = endpoints.value.ip_address
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

