terraform {
  experiments = [module_variable_optional_attrs]
}

variable "cdp" {
  description = "Create CDP Interface Policies."
  type = map(object({
    admin_state = optional(string)
    annotation  = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
  }))
  default = {
    default = {
      admin_state = "enabled" # Options are (enabled|disabled)
      annotation  = ""
      name        = "cdp_enabled"
      name_alias  = ""
    }
  }
}

variable "fc_interface" {
  description = "Create Fibre-Channel Interface Policies."
  type = map(object({
    automaxspeed = optional(string)
    annotation   = optional(string)
    description  = optional(string)
    fill_pattern = optional(string)
    name         = optional(string)
    name_alias   = optional(string)
    port_mode    = optional(string)
    rx_bb_credit = optional(number)
    speed        = optional(string)
    trunk_mode   = optional(string)
  }))
  default = {
    default = {
      automaxspeed = "32G" # Options are (4G|8G|16G|32G)
      annotation   = ""
      description  = ""
      fill_pattern = "IDLE" # Options are (ARBFF|IDLE)
      name         = "auto_f_port"
      name_alias   = ""
      port_mode    = "f"         # Options are (f|np)
      rx_bb_credit = 64          # Range is 16-64
      speed        = "auto"      # Options are (auto|4G|8G|16G|32G)
      trunk_mode   = "trunk-off" # Options are (auto|trunk-off|trunk-on)
    }
  }
}

variable "l2_interface" {
  description = "Create L2 Interface Policies.  Components are QnQ, Reflective Relay, and VLAN Scope"
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
    qinq        = optional(string)
    vepa        = optional(string)
    vlan_scope  = optional(string)
  }))
  default = {
    default = {
      annotation  = ""
      description = ""
      name        = "default"
      name_alias  = ""
      qinq        = "disabled" # Options are (corePort|disabled|doubleQtagPort|edgePort)
      vepa        = "disabled" # Reflective Relay (802.1Qbg).  Options are (disabled|enabled)
      vlan_scope  = "global"   # Options are (global|portlocal)
    }
  }
}

variable "lacp" {
  description = "Create LACP Interface Policies."
  type = map(object({
    annotation  = optional(string)
    ctrl        = optional(list(string))
    description = optional(string)
    max_links   = optional(number)
    min_links   = optional(number)
    name        = optional(string)
    name_alias  = optional(string)
    mode        = optional(string)
  }))
  default = {
    default = {
      annotation  = ""
      ctrl        = ["fast-sel-hot-stdby", "graceful-conv", "susp-individual"] # This is a list.  Options are ("graceful-conv"|"fast-sel-hot-stdby"|"load-defer"|"susp-individual"|"symmetric-hash")
      description = ""
      max_links   = 16 # Range is 1-16
      min_links   = 1  # Range is 1-16
      name        = "lacp_active"
      name_alias  = ""
      mode        = "active" # Options are (active|off|mac-pin|mac-pin-nicload|passive).  Default is off
    }
  }
}

variable "link_level" {
  description = "Create Link Level Interface Policies."
  type = map(object({
    annotation    = optional(string)
    auto_neg      = optional(string)
    description   = optional(string)
    fec_mode      = optional(string)
    link_debounce = optional(number)
    name          = optional(string)
    name_alias    = optional(string)
    speed         = optional(string)
  }))
  default = {
    default = {
      annotation    = ""
      auto_neg      = "on" # Options are (on|off|on-enforce)... on-enforce is only supported on 5.0(1)+
      description   = ""
      fec_mode      = "inherit" # Options are (inherit|cl74-fc-fec|cl91-rs-fec|cons16-rs-fec|disable-fec|ieee-rs-fec|kp-fec)
      link_debounce = 100       # Range is 0-5000
      name          = "inherit_auto"
      name_alias    = ""
      speed         = "inherit" # Options are (inherit|100M|1G|10G|25G|40G|50G|100G|200G|400G)
    }
  }
}

variable "lldp" {
  description = "Create LLDP Interface Policies."
  type = map(object({
    admin_rx_st = optional(string)
    admin_tx_st = optional(string)
    annotation  = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
  }))
  default = {
    default = {
      admin_rx_st = "enabled" # Options are (enabled|disabled)
      admin_tx_st = "enabled" # Options are (enabled|disabled)
      annotation  = ""
      description = ""
      name        = "lldp_both_enabled"
      name_alias  = ""
    }
  }
}

variable "mcp" {
  description = "Create Mis-Cabling Protocol Policies."
  type = map(object({
    admin_state = optional(string)
    annotation  = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
  }))
  default = {
    default = {
      admin_state = "enabled" # Options are (enabled|disabled)
      annotation  = ""
      description = ""
      name        = "mcp_enabled"
      name_alias  = ""
    }
  }
}

variable "port_security" {
  description = "Create Port Security Policies."
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    maximum     = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
    timeout     = optional(number)
    violation   = optional(string)
  }))
  default = {
    default = {
      annotation  = ""
      description = ""
      maximum     = 0 # Range is 0-12000. Default is 0 which is disabled
      name        = "default"
      name_alias  = ""
      timeout     = 60        # Range is 60-3600.  60 is the defaut.
      violation   = "protect" # Protect is the only Option.
    }
  }
}

variable "stp" {
  description = "Create Spanning-Tree (BPDU) Interface Policies."
  type = map(object({
    annotation  = optional(string)
    ctrl        = optional(string)
    description = optional(string)
    name        = optional(string)
    name_alias  = optional(string)
  }))
  default = {
    default = {
      annotation  = ""
      ctrl        = "" # This is a list.  Options are (bpdu-filter|bpdu-guard)
      description = ""
      name        = "bpdu_ft_gd"
      name_alias  = ""
    }
  }
}

variable "storm_control" {
  description = "Create Storm Control Interface Policies."
  type = map(object({
    annotation            = optional(string)
    description           = optional(string)
    name                  = optional(string)
    name_alias            = optional(string)
    action                = optional(string)
    bc_rate_percent       = optional(string)
    bc_rate_burst_percent = optional(string)
    mc_rate_percent       = optional(string)
    mc_rate_burst_percent = optional(string)
    uc_rate_percent       = optional(string)
    uc_rate_burst_percent = optional(string)
    bc_rate_pps           = optional(string)
    bc_rate_burst_pps     = optional(string)
    mc_rate_pps           = optional(string)
    mc_rate_burst_pps     = optional(string)
    uc_rate_pps           = optional(string)
    uc_rate_burst_pps     = optional(string)
  }))
  default = {
    default = {
      annotation            = ""
      description           = ""
      name                  = "default"
      name_alias            = ""
      action                = "drop" # Options are (drop|shutdown)
      bc_rate_percent       = "100.000000"
      bc_rate_burst_percent = "100.000000"
      mc_rate_percent       = "100.000000"
      mc_rate_burst_percent = "100.000000"
      uc_rate_percent       = "100.000000"
      uc_rate_burst_percent = "100.000000"
      bc_rate_pps           = "unspecified"
      bc_rate_burst_pps     = "unspecified"
      mc_rate_pps           = "unspecified"
      mc_rate_burst_pps     = "unspecified"
      uc_rate_pps           = "unspecified"
      uc_rate_burst_pps     = "unspecified"
    }
  }
}


locals {

  cdp = {
    for k, v in var.cdp : k => {
      admin_state = coalesce(v.admin_state, "enabled")
      annotation  = (v.annotation != null ? v.annotation : "")
      # description   = (v.description != null ? v.description : "")
      name       = coalesce(v.name, "cdp_enabled")
      name_alias = (v.name_alias != null ? v.name_alias : "")
    }
  }

  fc_interface = {
    for k, v in var.fc_interface : k => {
      automaxspeed = coalesce(v.automaxspeed, "32G")
      annotation   = (v.annotation != null ? v.annotation : "")
      description  = (v.description != null ? v.description : "")
      fill_pattern = coalesce(v.fill_pattern, "IDLE")
      name         = coalesce(v.name, "auto_f_port")
      name_alias   = (v.name_alias != null ? v.name_alias : "")
      port_mode    = coalesce(v.port_mode, "f")
      rx_bb_credit = coalesce(v.rx_bb_credit, 64)
      speed        = coalesce(v.speed, "auto")
      trunk_mode   = coalesce(v.trunk_mode, "trunk-off")
    }
  }

  l2_interface = {
    for k, v in var.l2_interface : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      description = (v.description != null ? v.description : "")
      name        = coalesce(v.name, "default")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
      qinq        = coalesce(v.qinq, "disabled")
      vepa        = coalesce(v.vepa, "disabled")
      vlan_scope  = coalesce(v.vlan_scope, "global")
    }
  }

  lacp = {
    for k, v in var.lacp : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      ctrl        = coalesce(v.ctrl, ["fast-sel-hot-stdby", "graceful-conv", "susp-individual"])
      description = (v.description != null ? v.description : "")
      max_links   = coalesce(v.max_links, 16)
      min_links   = coalesce(v.min_links, 1)
      name        = coalesce(v.name, "lacp_active")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
      mode        = coalesce(v.mode, "active")
    }
  }

  link_level = {
    for k, v in var.link_level : k => {
      annotation    = (v.annotation != null ? v.annotation : "")
      auto_neg      = coalesce(v.auto_neg, "on")
      description   = (v.description != null ? v.description : "")
      fec_mode      = coalesce(v.fec_mode, "inherit")
      link_debounce = coalesce(v.link_debounce, 100)
      name          = coalesce(v.name, "inherit_auto")
      name_alias    = (v.name_alias != null ? v.name_alias : "")
      speed         = coalesce(v.speed, "inherit")
    }
  }

  lldp = {
    for k, v in var.lldp : k => {
      admin_rx_st = coalesce(v.admin_rx_st, "enabled")
      admin_tx_st = coalesce(v.admin_tx_st, "enabled")
      annotation  = (v.annotation != null ? v.annotation : "")
      description = (v.description != null ? v.description : "")
      name        = coalesce(v.name, "lldp_both_enabled")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
    }
  }

  mcp = {
    for k, v in var.mcp : k => {
      admin_state = coalesce(v.admin_state, "enabled")
      annotation  = (v.annotation != null ? v.annotation : "")
      # description   = (v.description != null ? v.description : "")
      name       = coalesce(v.name, "mcp_enabled")
      name_alias = (v.name_alias != null ? v.name_alias : "")
    }
  }

  port_security = {
    for k, v in var.port_security : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      description = (v.description != null ? v.description : "")
      maximum     = coalesce(v.maximum, 0)
      name        = coalesce(v.name, "default")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
      timeout     = coalesce(v.timeout, 60)
      violation   = coalesce(v.violation, "protect")
    }
  }

  stp = {
    for k, v in var.stp : k => {
      annotation  = (v.annotation != null ? v.annotation : "")
      ctrl        = (v.ctrl != null ? v.ctrl : "")
      description = (v.description != null ? v.description : "")
      name        = coalesce(v.name, "bpdu_fg")
      name_alias  = (v.name_alias != null ? v.name_alias : "")
    }
  }

  storm_control = {
    for k, v in var.storm_control : k => {
      annotation            = (v.annotation != null ? v.annotation : "")
      description           = (v.description != null ? v.description : "")
      name                  = coalesce(v.name, "default")
      name_alias            = (v.name_alias != null ? v.name_alias : "")
      action                = coalesce(v.action, "drop")
      bc_rate_percent       = coalesce(v.bc_rate_percent, "100.000000")
      bc_rate_burst_percent = coalesce(v.bc_rate_burst_percent, "100.000000")
      mc_rate_percent       = coalesce(v.mc_rate_percent, "100.000000")
      mc_rate_burst_percent = coalesce(v.mc_rate_burst_percent, "100.000000")
      uc_rate_percent       = coalesce(v.uc_rate_percent, "100.000000")
      uc_rate_burst_percent = coalesce(v.uc_rate_burst_percent, "100.000000")
      bc_rate_pps           = coalesce(v.bc_rate_pps, "unspecified")
      bc_rate_burst_pps     = coalesce(v.bc_rate_burst_pps, "unspecified")
      mc_rate_pps           = coalesce(v.mc_rate_pps, "unspecified")
      mc_rate_burst_pps     = coalesce(v.mc_rate_pps, "unspecified")
      uc_rate_pps           = coalesce(v.uc_rate_pps, "unspecified")
      uc_rate_burst_pps     = coalesce(v.uc_rate_burst_pps, "unspecified")
    }
  }
}
