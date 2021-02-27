#-----------------------------
#  dc1-leaf202
#-----------------------------

module "dc1-leaf202_membership" {
  source = "../modules/fabric_membership"
  membership = {
    "dc1-leaf202" = {
      # fabric_id   = 1 # is already the default
      name    = "dc1-leaf202"
      node_id = 202
      # node_type   = "unspecified" # is already the default
      # pod_id      = 1 # is already the default
      # role        = "leaf" # is already the default
      serial = "TEP-1-102"
    }
  }
}

output "dc1-leaf202_membership" {
  value = { for v in sort(keys(module.dc1-leaf202_membership)) : v => module.dc1-leaf202_membership[v] }
}

module "dc1-leaf202_interface_profile" {
  source = "../modules/leaf_interface_profile"
  leaf_interface_profile = {
    "dc1-leaf202" = {
      description = "dc1-leaf202 Interface Profile"
      name        = "dc1-leaf202"
    }
  }
}

output "dc1-leaf202_interface_profile" {
  value = { for v in sort(keys(module.dc1-leaf202_interface_profile)) : v => module.dc1-leaf202_interface_profile[v] }
}

module "dc1-leaf202_leaf_profile" {
  source     = "../modules/leaf_profile_single"
  depends_on = [module.dc1-leaf202_interface_profile]
  leaf_profile = {
    "dc1-leaf202" = {
      description            = "dc1-leaf202 Leaf Profile"
      name                   = "dc1-leaf202"
      leaf_interface_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      leaf_selector_name     = "dc1-leaf202"
      # switch_association_type = "range" # is already the default
      node_block_name = "dc1-leaf202"
      node_block_from = 202
      node_block_to   = 202
    }
  }
}

module "dc1-leaf202_policy_group" {
  source     = "../modules/leaf_profile_to_pg"
  depends_on = [module.dc1-leaf202_interface_profile, module.leaf_policy_group]
  leaf_profile_policy_group = {
    "policy_group" = {
      leaf_profile_name  = "dc1-leaf202"
      leaf_policy_group  = module.leaf_policy_group.leaf_policy_group["default"]
      leaf_selector_name = "dc1-leaf202"
      # switch_association_type = "range" # is already the default
    }
  }
}

module "dc1-leaf202_interface_selectors" {
  source     = "../modules/leaf_interface_selectors"
  depends_on = [module.leaf_interface_policy_groups, module.dc1-leaf202_interface_profile]
  interface_selectors = {
    "Eth1-01" = {
      description  = "dc1-leaf202 Eth1/1 to endpointxyz"
      leaf_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      name         = "Eth1-01"
      policy_group = module.leaf_interface_policy_groups.access["access"]
      # selector_type = "range" # range is already the default
    }
    "Eth1-02" = {
      description  = "dc1-leaf202 Eth1/2 to server"
      leaf_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      name         = "Eth1-02"
      policy_group = module.leaf_interface_policy_groups.bundle["server_vpc"]
      # selector_type = "range" # range is already the default
    }
    "Eth1-49" = {
      description  = "dc1-leaf202 Eth1/49 Breakout Port"
      leaf_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      name         = "Eth1-49"
      policy_group = module.leaf_interface_policy_groups.breakout["25g-4x"]
      # selector_type = "range" # range is already the default
    }
    "Eth1-49-1" = {
      description  = "dc1-leaf202 Eth1/49 Breakout Port"
      leaf_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      name         = "Eth1-49-1"
      policy_group = module.leaf_interface_policy_groups.access["access"]
      # selector_type = "range" # range is already the default
    }
    "Eth1-49-2" = {
      description  = "dc1-leaf202 Eth1/49 Breakout Port"
      leaf_profile = module.dc1-leaf202_interface_profile.leaf_interface_profile["dc1-leaf202"]
      name         = "Eth1-49-2"
      policy_group = module.leaf_interface_policy_groups.bundle["server_vpc"]
      # selector_type = "range" # range is already the default
    }
  }
}

output "dc1-leaf202_interface_selectors" {
  value = { for v in sort(keys(module.dc1-leaf202_interface_selectors)) : v => module.dc1-leaf202_interface_selectors[v] }
}

module "dc1-leaf202_interface_blocks" {
  source     = "../modules/leaf_interface_selectors_block"
  depends_on = [module.dc1-leaf202_interface_selectors]
  port_block = {
    "Eth1-01" = {
      description        = "Connection to endpointxyz"
      interface_selector = module.dc1-leaf202_interface_selectors.interface_selectors["Eth1-01"]
      name               = "Eth1-01"
      # module_from         = 1 # Module 1 is already the default
      # module_to           = 1 # Module 1 is already the default
      # port_from           = 1 # Port 1 is already the default
      # port_to             = 1 # Port 1 is already the default
    }
    "Eth1-02" = {
      description        = "Connection to server1"
      interface_selector = module.dc1-leaf202_interface_selectors.interface_selectors["Eth1-02"]
      name               = "Eth1-02"
      port_from          = 2
      port_to            = 2
    }
    "Eth1-49" = {
      description        = "Breakout Port 1/49"
      interface_selector = module.dc1-leaf202_interface_selectors.interface_selectors["Eth1-49"]
      name               = "Eth1-49"
      port_from          = 49
      port_to            = 49
    }
  }
}

module "dc1-leaf202_interface_sub_blocks" {
  source     = "../modules/leaf_interface_selectors_block_sub"
  depends_on = [module.dc1-leaf202_interface_selectors]
  port_block_sub = {
    "Eth1-49-1" = {
      description        = "Connection to endpointzyx"
      interface_selector = module.dc1-leaf202_interface_selectors.interface_selectors["Eth1-49-1"]
      name               = "Eth1-49-1"
      port_from          = 49
      port_to            = 49
      # sub_port_from       = 1 # Sub-port 1 is already the default
      # sub_port_to         = 1 # Sub-port 1 is already the default
    }
    "Eth1-49-2" = {
      description        = "Connection to endpointzyx"
      interface_selector = module.dc1-leaf202_interface_selectors.interface_selectors["Eth1-49-2"]
      name               = "Eth1-49-2"
      port_from          = 49
      port_to            = 49
      sub_port_from      = 2
      sub_port_to        = 2
    }
  }
}