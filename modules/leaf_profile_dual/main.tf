/*
API Information:
 - Class: "infraLeafS"
 - Distinguished Name: "uni/infra/nprof-{Name}"
GUI Location:
 - Fabric > Access Policies > Switches > Leaf Switches > Profiles > {Name}
*/
resource "aci_leaf_profile" "leaf_profile" {
  for_each   = local.leaf_profile
  annotation = each.value["annotation"]
  # description                   = each.value["description"]
  name                         = each.value["name"]
  name_alias                   = each.value["name_alias"]
  relation_infra_rs_acc_port_p = [each.value["leaf_interface_profile"]]
  leaf_selector {
    name                    = each.value["leaf_selector_name_1"]
    switch_association_type = each.value["switch_association_type_1"]
    node_block {
      name  = each.value["node_block1_name"]
      from_ = each.value["node_block1_from"]
      to_   = each.value["node_block1_to"]
    }
  }
  leaf_selector {
    name                    = each.value["leaf_selector_name_2"]
    switch_association_type = each.value["switch_association_type_2"]
    node_block {
      name  = each.value["node_block2_name"]
      from_ = each.value["node_block2_from"]
      to_   = each.value["node_block2_to"]
    }
  }
}
