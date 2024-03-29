#------------------------------------------
# Create Spine Policy Group
#------------------------------------------

/*
API Information:
 - Class: "infraSpineAccNodePGrp"
 - Distinguished Name: "uni/infra/funcprof/spaccnodepgrp-{name}"
GUI Location:
 - Fabric > Access Policies > Switches > Spine Switches > Policy Groups: {name}
*/
resource "aci_rest" "spine_policy_group" {
  for_each   = local.spine_policy_group
  path       = "/api/node/mo/uni/infra/funcprof/spaccnodepgrp-${each.value.name}.json"
  class_name = "infraSpineAccNodePGrp"
  payload    = <<EOF
{
	"infraSpineAccNodePGrp": {
		"attributes": {
			"dn": "uni/infra/funcprof/spaccnodepgrp-${each.value.name}",
			"descr": "${each.value.description}",
			"name": "${each.value.name}"
		},
		"children": [
			{
				"infraRsSpineCoppProfile": {
					"attributes": {
						"tnCoppSpineProfileName": "${each.value.copp_spine_plcy}"
					},
					"children": []
				}
			},
			{
				"infraRsSpineBfdIpv4InstPol": {
					"attributes": {
						"tnBfdIpv4InstPolName": "${each.value.bfd_ipv4_plcy}"
					},
					"children": []
				}
			},
			{
				"infraRsSpineBfdIpv6InstPol": {
					"attributes": {
						"tnBfdIpv6InstPolName": "${each.value.bfd_ipv6_plcy}"
					},
					"children": []
				}
			},
			{
				"infraRsIaclSpineProfile": {
					"attributes": {
						"tnIaclSpineProfileName": "${each.value.copp_pre_filter}"
					},
					"children": []
				}
			},
			{
				"infraRsSpinePGrpToCdpIfPol": {
					"attributes": {
						"tnCdpIfPolName": "${each.value.cdp_policy}"
					},
					"children": []
				}
			},
			{
				"infraRsSpinePGrpToLldpIfPol": {
					"attributes": {
						"tnLldpIfPolName": "${each.value.lldp_policy}"
					},
					"children": []
				}
			}
		]
	}
}
	EOF
}
