/*
API Information:
 - Class: "infraLeafS"
 - Class: "infraRsAccNodePGrp"
 - Distinguished Name: "uni/infra/nprof-{name}/leaves-{name}-typ-range"
GUI Location:
 - Fabric > Access Policies > Switches > Leaf Switches > Profiles > {name}: Leaf Selectors Policy Group: {name}
*/
resource "aci_rest" "leaf_profile_policy_group" {
  for_each   = local.leaf_profile_policy_group
  path       = "/api/node/mo/uni/infra/nprof-${each.value["leaf_profile_name"]}/leaves-${each.value["leaf_selector_name"]}-typ-${each.value["switch_association_type"]}.json"
  class_name = "infraLeafS"
  payload    = <<EOF
{
  "infraLeafS": {
    "attributes": {
      "dn": "uni/infra/nprof-${each.value["leaf_profile_name"]}/leaves-${each.value["leaf_selector_name"]}-typ-${each.value["switch_association_type"]}"
    },
    "children": [
      {
        "infraRsAccNodePGrp": {
          "attributes": {
            "tDn": "${each.value["leaf_policy_group"]}"
          },
          "children": []
        }
      }
    ]
  }
}
  EOF
}
