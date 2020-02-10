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
variable "bucket" {}

variable "accesskey" {}

variable "secretkey" {}

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

variable "adminPassword" {}

variable "base64_key" {}

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
