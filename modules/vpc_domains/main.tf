#----------------------------------------------
# Create a VPC Domain Pair
#----------------------------------------------

/*
API Information:
 - Class: "fabricExplicitGEp"
 - Distinguished Name: "uni/fabric/protpol/expgep-{Name}"
GUI Location:
 - Fabric > Access Policies > Policies > Virtual Port Channel default
*/
resource "aci_rest" "vpc_domains" {
  for_each   = local.vpc_domains
  path       = "/api/node/mo/uni/fabric/protpol/expgep-${each.value["name"]}.json"
  class_name = "fabricExplicitGEp"
  payload    = <<EOF
{
  "fabricExplicitGEp": {
    "attributes": {
      "annotation": "${each.value["annotation_domain"]}",
      "dn": "uni/fabric/protpol/expgep-${each.value["name"]}",
      "id": "${each.value["vpc_domain_id"]}",
      "name": "${each.value["name"]}"
    },
    "children": [
      {
        "fabricNodePEp": {
          "attributes": {
            "annotation": "${each.value["annotation_node1"]}",
            "dn": "uni/fabric/protpol/expgep-${each.value["name"]}/nodepep-${each.value["node1_id"]}",
            "id": "${each.value["node1_id"]}",
            "nameAlias": "${each.value["name_alias_node1"]}",
            "podId": "${each.value["pod_id"]}"
          },
          "children": []
        }
      },
      {
        "fabricNodePEp": {
          "attributes": {
            "annotation": "${each.value["annotation_node2"]}",
            "dn": "uni/fabric/protpol/expgep-${each.value["name"]}/nodepep-${each.value["node2_id"]}",
            "id": "${each.value["node2_id"]}",
            "nameAlias": "${each.value["name_alias_node2"]}",
            "podId": "${each.value["pod_id"]}"
          },
          "children": []
        }
      },
      {
        "fabricRsVpcInstPol": {
          "attributes": {
            "annotation": "${each.value["annotation_domain_policy"]}",
            "tnVpcInstPolName": "${each.value["domain_policy"]}"
          },
          "children": []
        }
      }
    ]
  }
}
	EOF
}
