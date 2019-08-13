// This provider defines an alias and is targetable by resources by including `provider = "oci.phx"`. 
provider "oci" {
  region           = "us-phoenix-1"
  alias            = "phx"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}

// This provider defines an alias and is targetable by resources by including `provider = "oci.iad"`. 
provider "oci" {
  region           = "us-ashburn-1"
  alias            = "iad"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}
