# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "ssh_public_key"       {}


# OCI Profile
variable "tenant"               {default = "your_tenancy_name"}

# Object Storage
variable "bucket"		{default = "fusion_metadata"}
variable "accesskey" 		{default = "ocid1.credential.oc1..key"}
variable "secretkey"	 	{default = "your_secret_key"}
variable "endpointurl" {
   type = "map"
   default = {
     us-phoenix-1 = "https://your_tenancy_name.compat.objectstorage.us-phoenix-1.oraclecloud.com"
     us-ashburn-1 = "https://your_tenancy_name.compat.objectstorage.us-ashburn-1.oraclecloud.com"
   }
}

# Note: region variable is set in region.tf
# assume 2 regions

# Vars Required by Fusion
# name uses subnet name instead of region
variable "fqdn" {
   type = "map"
   default = {
     us-phoenix-1 = "fusion-server.phoenix.fusion.oraclevcn.com"
     us-ashburn-1 = "fusion-server.ashburn.fusion.oraclevcn.com"
   }
}

# name distinguish servers in each location
variable "subnet" {
   type = "map"
   default = {
     us-phoenix-1 = "phoenix"
     us-ashburn-1 = "ashburn"
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
    shape = "VM.Standard2.2"
    node_count = 1
    package = "s3://package"
    adminUsername = "admin"
    adminPassword = "admin"
    proxy = "0.0.0.0:8071"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Constants
# You probably don't need to change these.
# ---------------------------------------------------------------------------------------------------------------------

// https://docs.cloud.oracle.com/iaas/images/image/cf34ce27-e82d-4c1a-93e6-e55103f90164/
// Oracle-Linux-7.5-2018.08.14-0
variable "images" {
  type = "map"
  default = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakzrywmh7kwt7ugj5xqi5r4a7xoxsrxtc7nlsdyhmhqyp7ntobjwq"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa2tq67tvbeavcmioghquci6p3pvqwbneq3vfy7fe7m7geiga4cnxa"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaasez4lk2lucxcm52nslj5nhkvbvjtfies4yopwoy4b3vysg5iwjra"
    uk-london-1  = "ocid1.image.oc1.uk-london-1.aaaaaaaalsdgd47nl5tgb55sihdpqmqu2sbvvccjs6tmbkr4nx2pq5gkn63a"
  }
}
