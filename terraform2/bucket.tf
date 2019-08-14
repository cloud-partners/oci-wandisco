data "oci_objectstorage_namespace" "ns" {}

resource "oci_objectstorage_bucket" "bucket1" {
  compartment_id = "${var.compartment_ocid}"
  namespace      = "${data.oci_objectstorage_namespace.ns.namespace}"
  name           = "${var.bucket}"
  access_type    = "ObjectRead"
}

data "oci_objectstorage_bucket_summaries" "buckets1" {
  compartment_id = "${var.compartment_ocid}"
  namespace      = "${data.oci_objectstorage_namespace.ns.namespace}"

  filter {
    name   = "name"
    values = ["${oci_objectstorage_bucket.bucket1.name}"]
  }
}
