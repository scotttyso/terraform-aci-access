terraform {
  experiments = [module_variable_optional_attrs]
}

variable "port_block" {
  description = "Assign Physical Port(s) to a Leaf Interface Selector"
  type = map(object({
    annotation         = optional(string)
    description        = optional(string)
    interface_selector = optional(string)
    module_from        = optional(number)
    module_to          = optional(number)
    name               = optional(string)
    name_alias         = optional(string)
    port_from          = optional(number)
    port_to            = optional(number)
  }))
  default = {
    default = {
      annotation         = ""
      description        = ""
      interface_selector = ""
      module_from        = 1
      module_to          = 1 # The default value is the same as module_from.
      name               = "block2"
      name_alias         = ""
      port_from          = 1
      port_to            = 1 # The default value is the same as port_from.
    }
  }
}

locals {
  port_block = {
    for k, v in var.port_block : k => {
      annotation         = (v.annotation != null ? v.annotation : "")
      description        = (v.description != null ? v.description : "")
      interface_selector = (v.interface_selector != null ? v.interface_selector : "")
      module_from        = coalesce(v.module_from, 1)
      module_to          = coalesce(v.module_to, v.module_from, 1)
      name               = coalesce(v.name, "block2")
      name_alias         = (v.name_alias != null ? v.name_alias : "")
      port_from          = coalesce(v.port_from, 1)
      port_to            = coalesce(v.port_to, v.port_from, 1)
    }
  }
}
