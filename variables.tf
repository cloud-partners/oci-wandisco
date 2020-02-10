# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
variable "region" {}

variable "compartment_ocid" {}

variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "fingerprint" {}

variable "private_key_path" {}

variable "ssh_public_key" {}

# Object Storage
variable "bucket" {
}

variable "accesskey" {
  default = "cdd7cefb47c573d847d8cecba75d96658ede6312"
}

variable "secretkey" {
  default = "QVM2lZ7O8WNa6V8iG/PP4jOVqi3pjlE+iH3M/Sumots="
}

variable "zone" {
  default = "Proxy1"
}

# ---------------------------------------------------------------------------------------------------------------------
# Fusion variables
# ---------------------------------------------------------------------------------------------------------------------

variable "shape" {
  default = "VM.Standard2.1"
}

variable "adminUsername" {
  default = "admin"
}

variable "adminPassword" {
  default = "admin"
}

variable "node_count" {
  default = 1
}

variable "base64_key" {
  default = "Rxk49P0DE6859kmQVrttpavRcgrUllgZhinnqxO+IpjC7ZPRv6DM7PnG4Qh6Nyg5FCkwoSg/NoTBu1iB8XK9kO8MWWgVDOfjIi4wQC6w6ScIrTUmLrXS+Qlx3yJK98MwHSj5NjxQGD7HJPJylDeTy98oV5dY2aqmp5H1xc0nCFGErXKJWe9YaEsjmibCniMlTDl5amb2AH4tWWyROPHJnZ1Gr/1R7uVZN1KgavcdgWk7nBHv5iCzXl/pJzsYs1xwelU7kF0Hl9LuPfRbKg6M8ErmkbbKaKrYHWcarR8od1NCWy/h1805MuOYAcY8FL/2B5atZpnwjPWriR+mjSUbzB6swRCYSyUAxDWtLn6K8p2zxKvyV98Oh9+H+urAjGLtFWoIS6zMPFPVAaoSp3d8ys8WkX7PThY3aAMfzVOoHqCHOWFkczuQKKSOvxK/3KiBFLIxTiQ2ZzDmrkXrdNMC0NHN1lHMcUTC2KK5Xa5fNfJD2Dju26GRKKHi0ocRGGS6jnbod6GxpArdamoFuSeFV/Pt/R5j2YlDtPzYAs3Kyuf/qG6LjydgsXlPDXX0BsuvKmojNDmw1j3YNClQaf3tlZbr8UwG1xMQ2tQad+lDr3/g7+n4NIy9zkkv3Ob7g7Ca3blJup9I4GR/gIr+UYE+VxwKfCyfYf28z8Q2RlSDmec="
}

variable "proxy" {
  default = "0.0.0.0:8071"
}

# ---------------------------------------------------------------------------------------------------------------------
# Constants
# You probably don't need to change these.
# ---------------------------------------------------------------------------------------------------------------------

variable "mp_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaafvrpzsiavznbomp2z3xulek7dmq6jnh6mg7mr3lwdecquvubqf2a"
}

variable "mp_listing_resource_id" {
  default = "ocid1.image.oc1..aaaaaaaa4dcvtg7vwyqa5mzhzkup5u4lsalyks5tjxfrk5pqtzc2pd2slikq"
}

variable "mp_listing_resource_version" {
  default = "baseimage-1.0"
}

variable "use_marketplace_image" {
  default = true
}

variable "image" {
  default = ""
}
