resource "oci_core_instance" "fusion_server" {
  display_name        = "fusion_server"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0]["name"]
  shape               = var.fusion_server["shape"]
  subnet_id           = oci_core_subnet.subnet.id
  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(
      format(
        "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
        "#!/usr/bin/env bash",
        "export PackageLocation=${var.fusion_server["package"]}",
        "export adminUsername=${var.fusion_server["adminUsername"]}",
        "export adminPassword=${var.fusion_server["adminPassword"]}",
        "export proxy=${var.fusion_server["proxy"]}",
        "export fqdn=${var.fqdn[var.region]}",
        "export zone=${var.zone[var.region]}",
        "export node=${var.zone[var.region]}_Node",
        "export bucket=${var.bucket}",
        "export region=${var.region}",
        "export endpointurl=${var.endpointurl[var.region]}",
        "export accesskey=${var.accesskey}",
        "export secretkey=${var.secretkey}",
        file("../scripts/server.sh"),
      ),
    )
  }
  count = var.fusion_server["node_count"]
}

data "oci_core_vnic_attachments" "fusion_server_vnic_attachments" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0]["name"]

  #availability_domain2 = "QbgC:PHX-AD-1"
  instance_id = oci_core_instance.fusion_server[0].id
}

data "oci_core_vnic" "fusion_server_vnic" {
  vnic_id = data.oci_core_vnic_attachments.fusion_server_vnic_attachments.vnic_attachments[0]["vnic_id"]
}

output "server_IP" {
  value = [
    "${data.oci_core_vnic.fusion_server_vnic.public_ip_address} ${var.fqdn[var.region]} ",
    "In about 5 mintues, browse and login with this FusionServerURL: http://${data.oci_core_vnic.fusion_server_vnic.public_ip_address}:8083 ",
    "    with username:  ${var.fusion_server["adminUsername"]} ",
    "     and password:  ${var.fusion_server["adminPassword"]}",
  ]
}
