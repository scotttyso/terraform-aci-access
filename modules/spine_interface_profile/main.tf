/*
API Information:
 - Class: "infraSpAccPortP"
 - Distinguished Name: "uni/infra/spaccportprof-{Name}"
GUI Location:
 - Fabric > Access Policies > Interfaces > Spine Interfaces > Profiles > {Name}
*/
resource "aci_spine_interface_profile" "spine_interface_profile" {
  for_each    = local.spine_interface_profile
  annotation  = each.value["annotation"]
  description = each.value["description"]
  name        = each.value["name"]
  name_alias  = each.value["name_alias"]
}
