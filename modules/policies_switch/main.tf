#-------------------------------------------------------
# Create Fast Link Failover Switch Policies
#-------------------------------------------------------

/*
API Information:
 - Class: "topoctrlFastLinkFailoverInstPol"
 - Distinguished Name: "uni/infra/fastlinkfailoverinstpol-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Switch > Fast Link Failover : {Policy Name}
*/
resource "aci_rest" "fast_link_failover" {
  for_each   = local.fast_link_failover
  path       = "/api/node/mo/uni/infra/fastlinkfailoverinstpol-${each.value["name"]}.json"
  class_name = "topoctrlFastLinkFailoverInstPol"
  payload    = <<EOF
{
  "topoctrlFastLinkFailoverInstPol": {
    "attributes": {
      "dn": "uni/infra/fastlinkfailoverinstpol-${each.value["name"]}",
      "annotation": "${each.value["annotation"]}",
      "descr": "${each.value["description"]}",
      "name": "${each.value["name"]}",
      "nameAlias": "${each.value["name_alias"]}",
      "modeType": "${each.value["mode"]}"
    }
  }
}
  EOF
}

#-------------------------------------------------------
# Create Forwarding Scale Profile Switch Policies
#-------------------------------------------------------

/*
API Information:
 - Class: "topoctrlFwdScaleProfilePol"
 - Distinguished Name: "uni/infra/fwdscalepol-{Policy Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Switch > Forwarding Scale Profile : {Policy Name}
*/
resource "aci_rest" "forwarding_scale_profile" {
  for_each   = local.forwarding_scale_profile
  path       = "/api/node/mo/uni/infra/fwdscalepol-${each.value["name"]}.json"
  class_name = "topoctrlFwdScaleProfilePol"
  payload    = <<EOF
{
  "topoctrlFwdScaleProfilePol": {
    "attributes": {
      "dn": "uni/infra/fwdscalepol-${each.value["name"]}",
      "annotation": "${each.value["annotation"]}",
      "descr": "${each.value["description"]}",
      "name": "${each.value["name"]}",
      "nameAlias": "${each.value["name_alias"]}",
      "profType": "${each.value["profile"]}"
    }
  }
}
  EOF
}
