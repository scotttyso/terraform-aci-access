output "fast_link_failover" {
  description = "This output will provide the Fast Link Failover Policy ID."
  value       = { for v in sort(keys(aci_rest.fast_link_failover)) : v => aci_rest.fast_link_failover[v].id }
}

output "forwarding_scale_profile" {
  description = "This output will provide the Forwarding Scale Profile Policy ID."
  value       = { for v in sort(keys(aci_rest.forwarding_scale_profile)) : v => aci_rest.forwarding_scale_profile[v].id }
}
