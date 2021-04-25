#------------------------------------------
# Create CDP Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "cdpIfPol"
 - Distinguished Name: "uni/infra/cdpIfP-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > CDP Interface : {Policy Name}
*/
resource "aci_cdp_interface_policy" "cdp" {
  for_each   = local.cdp
  admin_st   = each.value["admin_state"]
  annotation = each.value["annotation"]
  name       = each.value["name"]
  name_alias = each.value["name_alias"]
}

#------------------------------------------
# Create Fibre-Channel Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "fcIfPol"
 - Distinguished Name: "uni/infra/fcIfPol-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Fibre Channel Interface : {Policy Name}
*/
resource "aci_interface_fc_policy" "fc_interface" {
  for_each     = local.fc_interface
  automaxspeed = each.value["automaxspeed"]
  annotation   = each.value["annotation"]
  description  = each.value["description"]
  fill_pattern = each.value["fill_pattern"]
  name         = each.value["name"]
  name_alias   = each.value["name_alias"]
  port_mode    = each.value["port_mode"]
  rx_bb_credit = each.value["rx_bb_credit"]
  speed        = each.value["speed"]
  trunk_mode   = each.value["trunk_mode"]
}

#------------------------------------------
# Create an L2 Interface Policy
#------------------------------------------

/*
API Information:
 - Class: "l2IfPol"
 - Distinguished Name: "uni/infra/l2IfP-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > L2 Interface : {Policy Name}
*/
resource "aci_l2_interface_policy" "l2_interface" {
  for_each    = local.l2_interface
  annotation  = each.value["annotation"]
  description = each.value["description"]
  name        = each.value["name"]
  name_alias  = each.value["name_alias"]
  qinq        = each.value["qinq"]
  vepa        = each.value["vepa"]
  vlan_scope  = each.value["vlan_scope"]
}

#------------------------------------------
# Create LACP Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "lacpLagPol"
 - Distinguished Name: "uni/infra/lacplagp-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Port Channel : {Policy Name}
*/
resource "aci_lacp_policy" "lacp" {
  for_each    = local.lacp
  annotation  = each.value["annotation"]
  ctrl        = each.value["ctrl"]
  description = each.value["description"]
  max_links   = each.value["max_links"]
  min_links   = each.value["min_links"]
  name        = each.value["name"]
  name_alias  = each.value["name_alias"]
  mode        = each.value["mode"]
}

#------------------------------------------
# Create Interface Link Level Policies
#------------------------------------------

/*
API Information:
 - Class: "fabricHIfPol"
 - Distinguished Name: "uni/infra/hintfpol-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Link Level : {Policy Name}
*/
resource "aci_fabric_if_pol" "link_level" {
  for_each      = local.link_level
  annotation    = each.value["annotation"]
  auto_neg      = each.value["auto_neg"]
  description   = each.value["description"]
  fec_mode      = each.value["fec_mode"]
  link_debounce = each.value["link_debounce"]
  name          = each.value["name"]
  name_alias    = each.value["name_alias"]
  speed         = each.value["speed"]
}

#------------------------------------------
# Create LLDP Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "lldpIfPol"
 - Distinguished Name: "uni/infra/lldpIfP-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > LLDP Interface : {Policy Name}
*/
resource "aci_lldp_interface_policy" "lldp" {
  for_each    = local.lldp
  admin_rx_st = each.value["admin_rx_st"]
  admin_tx_st = each.value["admin_tx_st"]
  annotation  = each.value["annotation"]
  description = each.value["description"]
  name        = each.value["name"]
  name_alias  = each.value["name_alias"]
}

#------------------------------------------
# Create Mis-Cabling Protocol Policies
#------------------------------------------

/*
API Information:
 - Class: "mcpIfPol"
 - Distinguished Name: "uni/infra/mcpIfP-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > MCP Interface : {Policy Name}
*/
resource "aci_miscabling_protocol_interface_policy" "mcp" {
  for_each   = local.mcp
  admin_st   = each.value["admin_state"]
  annotation = each.value["annotation"]
  # description = each.value["description"]
  name       = each.value["name"]
  name_alias = each.value["name_alias"]
}

#------------------------------------------
# Create Port Security Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "l2PortSecurityPol"
 - Distinguished Name: "uni/infra/portsecurityP-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Port Security : {Policy Name}
*/
resource "aci_port_security_policy" "port_security" {
  for_each    = local.port_security
  annotation  = each.value["annotation"]
  description = each.value["description"]
  maximum     = each.value["maximum"]
  name        = each.value["name"]
  name_alias  = each.value["name_alias"]
  timeout     = each.value["timeout"]
  violation   = each.value["violation"]
}

#------------------------------------------
# Create Spanning-Tree Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "stpIfPol"
 - Distinguished Name: "uni/infra/ifPol-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Spanning Tree Interface : {Policy Name}
*/
resource "aci_rest" "stp" {
  for_each   = local.stp
  path       = "/api/node/mo/uni/infra/ifPol-${each.value["name"]}.json"
  class_name = "stpIfPol"
  payload    = <<EOF
{
  "stpIfPol": {
    "attributes": {
      "dn": "uni/infra/ifPol-${each.value["name"]}",
      "annotation": "${each.value["annotation"]}",
      "ctrl": "${each.value["ctrl"]}",
      "descr": "${each.value["description"]}",
      "name": "${each.value["name"]}",
      "nameAlias": "${each.value["name_alias"]}"
    }
  }
}
  EOF
}

#------------------------------------------
# Create Storm Control Interface Policies
#------------------------------------------

/*
API Information:
 - Class: "stormctrlIfPol"
 - Distinguished Name: "uni/infra/stormctrlifp-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Storm Control : {Policy Name}
*/
resource "aci_rest" "storm_control" {
  for_each   = local.storm_control
  path       = "/api/node/mo/uni/infra/stormctrlifp-${each.value["name"]}.json"
  class_name = "stormctrlIfPol"
  payload    = <<EOF
{
  "stormctrlIfPol": {
      "attributes": {
          "dn": "uni/infra/stormctrlifp-${each.value["name"]}",
          "annotation": "${each.value["annotation"]}",
          "descr": "${each.value["description"]}",
          "name": "${each.value["name"]}",
          "nameAlias": "",
          "bcBurstPps": "${each.value["bc_rate_burst_pps"]}",
          "bcBurstRate": "${each.value["bc_rate_burst_percent"]}",
          "bcRate": "${each.value["bc_rate_percent"]}",
          "bcRatePps": "${each.value["bc_rate_pps"]}",
          "mcBurstPps": "${each.value["mc_rate_burst_pps"]}",
          "mcBurstRate": "${each.value["mc_rate_burst_percent"]}",
          "mcRate": "${each.value["mc_rate_percent"]}",
          "mcRatePps": "${each.value["mc_rate_pps"]}",
          "stormCtrlAction": "${each.value["action"]}",
          "uucBurstPps": "${each.value["uc_rate_burst_pps"]}",
          "uucBurstRate": "${each.value["uc_rate_burst_percent"]}",
          "uucRate": "${each.value["uc_rate_percent"]}",
          "uucRatePps": "${each.value["uc_rate_pps"]}"
    }
  }
}
  EOF
}
