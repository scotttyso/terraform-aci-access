#------------------------------------------
# Create Leaf Policy Group
#------------------------------------------

/*
API Information:
 - Class: "infraAccNodePGrp"
 - Distinguished Name: "uni/infra/funcprof/accnodepgrp-{name}"
GUI Location:
 - Fabric > Access Policies > Switches > Leaf Switches > Policy Groups: {name}
*/
resource "aci_rest" "leaf_policy_group" {
  for_each   = local.leaf_policy_group
  path       = "/api/node/mo/uni/infra/funcprof/accnodepgrp-${each.value.name}.json"
  class_name = "infraAccNodePGrp"
  payload    = <<EOF
{
  "infraAccNodePGrp": {
    "attributes": {
      "dn": "uni/infra/funcprof/accnodepgrp-${each.value.name}",
      "name": "${each.value.name}",
      "descr": "${each.value.description}",
    },
    "children": [
      {
        "infraRsMstInstPol": {
          "attributes": {
            "tnStpInstPolName": "${each.value.stp_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsBfdIpv4InstPol": {
          "attributes": {
            "tnBfdIpv4InstPolName": "${each.value.bfd_ipv4_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsBfdIpv6InstPol": {
          "attributes": {
            "tnBfdIpv6InstPolName": "${each.value.bfd_ipv6_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsFcInstPol": {
          "attributes": {
            "tnFcInstPolName": "${each.value.fc_node_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsPoeInstPol": {
          "attributes": {
            "tnPoeInstPolName": "${each.value.poe_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsFcFabricPol": {
          "attributes": {
            "tnFcFabricPolName": "${each.value.fc_san_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsMonNodeInfraPol": {
          "attributes": {
            "tnMonInfraPolName": "${each.value.monitor_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsNetflowNodePol": {
          "attributes": {
            "tnNetflowNodePolName": "${each.value.netflow_node_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsLeafCoppProfile": {
          "attributes": {
            "tnCoppLeafProfileName": "${each.value.copp_leaf_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsTopoctrlFwdScaleProfPol": {
          "attributes": {
            "tnTopoctrlFwdScaleProfilePolName": "${each.value.fwd_scale_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsTopoctrlFastLinkFailoverInstPol": {
          "attributes": {
            "tnTopoctrlFastLinkFailoverInstPolName": "${each.value.fast_link_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsL2NodeAuthPol": {
          "attributes": {
            "tnL2NodeAuthPolName": "${each.value.node_8021x_plcy}"
          },
          "children": []
        }
      },
      {
        "infraRsIaclLeafProfile": {
          "attributes": {
            "tnIaclLeafProfileName": "${each.value.copp_pre_filter}"
          },
          "children": []
        }
      },
      {
        "infraRsEquipmentFlashConfigPol": {
          "attributes": {
            "tnEquipmentFlashConfigPolName": "${each.value.flash_config}"
          },
          "children": []
        }
      },
      {
        "infraRsLeafPGrpToCdpIfPol": {
          "attributes": {
            "tnCdpIfPolName": "${each.value.cdp_policy}"
          },
          "children": []
        }
      },
      {
        "infraRsLeafPGrpToLldpIfPol": {
          "attributes": {
            "tnLldpIfPolName": "${each.value.lldp_policy}"
          },
          "children": []
        }
      },
    ]
  }
}
  EOF
}
