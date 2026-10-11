variable "privatelink_endpoint_services" {
  description = <<EOT
Map of privatelink_endpoint_services, attributes below
Required:
    - endpoint_service_id
    - private_link_id
    - project_id
    - provider_name
Optional:
    - delete_on_create_timeout
    - gcp_project_id
    - private_endpoint_ip_address
    - endpoints (block):
        - endpoint_name (optional)
        - ip_address (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
EOT

  type = map(object({
    endpoint_service_id         = string
    private_link_id             = string
    project_id                  = string
    provider_name               = string
    delete_on_create_timeout    = optional(bool)
    gcp_project_id              = optional(string)
    private_endpoint_ip_address = optional(string)
    endpoints = optional(list(object({
      endpoint_name = optional(string)
      ip_address    = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.privatelink_endpoint_services : (
        contains(["AWS", "AZURE", "GCP"], v.provider_name)
      )
    ])
    error_message = "must be one of: \"AWS\", \"AZURE\", \"GCP\""
  }
}

