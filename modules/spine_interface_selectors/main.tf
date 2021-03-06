#------------------------------------------
# Create Spine Interface Selector
#  - Attach Port Block
#  - Attach Spine Interface Policy Group
#------------------------------------------

/*
API Information:
 - Class: "infraSHPortS"
 - Distinguished Name: "uni/infra/spaccportprof-{name}/shports-{interface_selector}-typ-range"
GUI Location:
 - Fabric > Access Policies > Interfaces > Spine Interfaces > Profiles > {Spine Interface Profile}:{Spine Interface Selector}
*/
resource "aci_rest" "spine_interface_selectors" {
  for_each   = local.spine_interface_selectors
  path       = "/api/node/mo/${each.value["spine_profile"]}/shports-${each.value["name_selector"]}-typ-${each.value["selector_type"]}.json"
  class_name = "infraSHPortS"
  payload    = <<EOF
{
  "infraSHPortS": {
    "attributes": {
      "annotation": "${each.value["annotation_selector"]}",
      "descr": "${each.value["descr_selector"]}",
      "dn": "${each.value["spine_profile"]}/shports-${each.value["name_selector"]}-typ-${each.value["selector_type"]}",
      "name": "${each.value["name_selector"]}",
      "nameAlias": "${each.value["name_alias_selector"]}",
      "type": "${each.value["selector_type"]}",
    },
    "children": [
      {
        "infraPortBlk": {
          "attributes": {
            "annotation": "${each.value["annotation_block"]}",
            "descr": "${each.value["descr_block"]}",
            "fromCard": "${each.value["module_from"]}",
            "fromPort": "${each.value["port_from"]}",
            "name": "${each.value["name_block"]}",
            "nameAlias": "${each.value["name_alias_block"]}",
            "toCard": "${each.value["module_to"]}",
            "toPort": "${each.value["port_to"]}"
          }
        }
      },
      {
        "infraRsSpAccGrp": {
          "attributes": {
            "tDn": "${each.value["policy_group"]}"
          }
        }
      }
    ]
  }
}
	EOF
}
