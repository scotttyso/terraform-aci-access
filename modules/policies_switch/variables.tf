terraform {
  experiments = [module_variable_optional_attrs]
}

variable fast_link_failover {
  description = "Create Fast Link Failover Switch Policies."
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
    mode        = optional(string)
  }))
  default = {
    default = {
      name        = "default"
      name_alias  = ""
      description = ""
      annotation  = ""
      mode        = "on"
    }
  }
}

variable forwarding_scale_profile {
  description = "Create Forwarding Scale Profile Switch Policies."
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
    profile        = optional(string)
  }))
  default = {
    default = {
      name        = "default"
      name_alias  = ""
      description = ""
      annotation  = ""
      profile        = "dual-stack"
    }
  }
}

locals {
  fast_link_failover = {
    for k, v in var.fast_link_failover : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      description = (v.description != null ? v.description : "")
      name        = coalesce(v.name, "default")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
      mode        = coalesce(v.mode, "on")
    }
  }
  forwarding_scale_profile = {
    for k, v in var.forwarding_scale_profile : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      description = (v.description != null ? v.description : "")
      name        = coalesce(v.name, "default")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
      profile        = coalesce(v.profile, "dual-stack")
    }
  }
}
