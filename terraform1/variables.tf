# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
#variable "compartment_ocid" {}
#variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
#variable "region"           {}

# OCI Profile
locals {
  tenant = "<your_tenancy_name>"
}

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}

# Key used to SSH to OCI VMs
variable "private_key_path" {}

variable "ssh_public_key" {}

variable "region" {
  default = "us-phoenix-1"
}

# Object Storage
variable "bucket" {
  default = "fusion_metadata"
}

# Enter your access key here, more info here: https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm#To4
variable "accesskey" {}

# Enter your access key here, more info here: https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm#To4
variable "secretkey" {}

variable "endpointurl" {
  type = "map"

  default = {
    us-phoenix-1 = "https://<your_tenancy_name>.compat.objectstorage.us-phoenix-1.oraclecloud.com"
    us-ashburn-1 = "https://<your_tenancy_name>.compat.objectstorage.us-ashburn-1.oraclecloud.com"
  }
}

# Note: region variable is set in region.tf
# assume 2 regions

# Vars Required by Fusion
# name uses subnet name instead of region

# name distinguish servers in each location
variable "subnet" {
  type = "map"

  default = {
    us-phoenix-1 = "phoenix"
    us-ashburn-1 = "ashburn"
  }
}

variable "fqdn" {
  type = "map"

  default = {
    us-phoenix-1 = "fusion-server.phoenix.fusion.oraclevcn.com"
    us-ashburn-1 = "fusion-server.ashburn.fusion.oraclevcn.com"
  }
}

variable "zone" {
  type = "map"

  default = {
    us-phoenix-1 = "Proxy1"
    us-ashburn-1 = "Proxy2"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# The defaults here will give you a cluster.  You can also modify these.
# ---------------------------------------------------------------------------------------------------------------------

variable "fusion_server" {
  type = "map"

  default = {
    shape         = "VM.Standard2.2"
    node_count    = 1
    package       = "s3://package"
    adminUsername = "admin"
    proxy         = "0.0.0.0:8071"
  }
}

// https://docs.cloud.oracle.com/iaas/images/image/cf34ce27-e82d-4c1a-93e6-e55103f90164/
// Oracle-Linux-7.6-2019.05.14-0
variable "images" {
  type = "map"

  default = {
    ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaalhbuvdg453ddyhvnbk4jsrw546zslcfyl7vl4oxfgplss3ovlm4q"
    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaamc2244t7h3gwrrci5z4ni2jsulwcg76gugupkb6epzrypawcz4hq"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaakjkxzw33dcocgu2oylpllue34tjtyngwru7pcpqn4qh2nwon7n7a"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaandqh4s7a3oe3on6osdbwysgddwqwyghbx4t4ryvtcwk5xikkpvhq"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa2xe7cufdwkksdazshtmqaddgd72kdhiyoqurtoukjklktf4nxkbq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaasorq3smbazoxvyqozz52ch5i5cexjojb7qvcefa5ubij2yjycy2a"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaa3vjdblyvw6rlz3jhjxudf6dpqsazqfynn3ziqrxyfox2wq5bdaq"
  }
}
