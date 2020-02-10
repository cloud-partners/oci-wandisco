locals {
  # Logic to choose platform or mkpl image based on
  # var.use_marketplace_image
  image          = var.use_marketplace_image ? var.mp_listing_resource_id : var.image
}

resource "oci_core_instance" "fusion_server" {
  display_name        = "fusion_server"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0]["name"]
  shape               = var.shape
  subnet_id           = oci_core_subnet.subnet.id
  source_details {
    source_id   = local.image
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(
      join(
        "\n",
        [
          "#!/usr/bin/env bash",
          "export adminUsername=${var.adminUsername}",
          "export adminPassword=${var.adminPassword}",
          "export proxy=${var.proxy}",
          "export fqdn=fusion-server.${oci_core_subnet.subnet.subnet_domain_name}",
          "export zone=${var.zone}",
          "export base64_key=${var.base64_key}",
          "export node=${var.zone}_Node",
          "export bucket=${var.bucket}",
          "export region=${var.region}",
          "export endpointurl=\"https://${data.oci_identity_tenancy.tenancy.name}.compat.objectstorage.${var.region}.oraclecloud.com\"",
          "export accesskey=${var.accesskey}",
          "export secretkey=${var.secretkey}",
          file("./scripts/server.sh"),
        ]
      ),
    )
  }
  count = 1
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

data "oci_identity_tenancy" "tenancy" {
  tenancy_id = "${var.tenancy_ocid}"
}


output "server_IP" {
  value = [
    "In about 5 mintues, browse and login with this FusionServerURL: http://${data.oci_core_vnic.fusion_server_vnic.public_ip_address}:8083 ",
    "    with username:  ${var.adminUsername} ",
    "    and password:  ${var.adminPassword}"
  ]
}
