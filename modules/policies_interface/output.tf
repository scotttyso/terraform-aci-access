output "cdp" {
  description = "This output will provide the CDP Policy ID."
  value       = { for v in sort(keys(aci_cdp_interface_policy.cdp)) : v => aci_cdp_interface_policy.cdp[v].id }
}

output "fc_interface" {
  description = "This output will provide the Fibre Channel Interface Policy ID."
  value       = { for v in sort(keys(aci_interface_fc_policy.fc_interface)) : v => aci_interface_fc_policy.fc_interface[v].id }
}

output "l2_interface" {
  description = "This output will provide the L2 Interface Policy ID."
  value       = { for v in sort(keys(aci_l2_interface_policy.l2_interface)) : v => aci_l2_interface_policy.l2_interface[v].id }
}

output "lacp" {
  description = "This output will provide the LACP Policy ID."
  value       = { for v in sort(keys(aci_lacp_policy.lacp)) : v => aci_lacp_policy.lacp[v].id }
}

output "link_level" {
  description = "This output will provide the Link Level Policy ID."
  value       = { for v in sort(keys(aci_fabric_if_pol.link_level)) : v => aci_fabric_if_pol.link_level[v].id }
}

output "lldp" {
  description = "This output will provide the LLDP Policy ID."
  value       = { for v in sort(keys(aci_lldp_interface_policy.lldp)) : v => aci_lldp_interface_policy.lldp[v].id }
}

output "mcp" {
  description = "This output will provide the Miscabling Protocol Policy ID."
  value       = { for v in sort(keys(aci_miscabling_protocol_interface_policy.mcp)) : v => aci_miscabling_protocol_interface_policy.mcp[v].id }
}

output "port_security" {
  description = "This output will provide the Port Security Policy ID."
  value       = { for v in sort(keys(aci_port_security_policy.port_security)) : v => aci_port_security_policy.port_security[v].id }
}

output "stp" {
  description = "This output will provide the Spanning Tree Policy ID."
  value       = { for v in sort(keys(aci_rest.stp)) : v => aci_rest.stp[v].id }
}

output "storm_control" {
  description = "This output will provide the Storm Control Policy ID."
  value       = { for v in sort(keys(aci_rest.storm_control)) : v => aci_rest.storm_control[v].id }
}