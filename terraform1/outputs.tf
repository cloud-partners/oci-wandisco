output "Your server has this IP" {
  value = ["${data.oci_core_vnic.fusion_server_vnic.public_ip_address}",
    "In about 5 minutes, browse and login with this FusionServerURL: http://${data.oci_core_vnic.fusion_server_vnic.public_ip_address}:8083 ",
    "    with username:  ${var.fusion_server["adminUsername"]} ",
    "     and password:  ${random_string.password.result}",
  ]
}
