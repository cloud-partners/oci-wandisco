# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
variable "region" {
}

variable "compartment_ocid" {
}

variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "ssh_public_key" {
}

# Object Storage
variable "bucket" {
  default = "mybucket"
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
 default = "VM.Standard2.2"
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

// https://docs.cloud.oracle.com/iaas/images/image/cf34ce27-e82d-4c1a-93e6-e55103f90164/
// Oracle-Linux-7.5-2018.08.14-0
variable "images" {
  type = map(string)
  default = {
      ap-mumbai-1 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
      ap-seoul-1 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
      ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
      ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
      ca-toronto-1 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
      eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
      eu-zurich-1 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
      sa-saopaulo-1 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
      uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
      us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
      us-langley-1 = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
      us-luke-1 = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
      us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
  }
}
