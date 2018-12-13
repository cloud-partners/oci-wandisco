# oci-fusion
[terraform](terraform) is a Terraform module that will deploy WANdisco Fusion on OCI. Instructions on how to use it are below.

## Prerequisites
First off you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

## Clone the Module
Now, you'll want a local copy of this repo.  You can make that with the commands:

    git clone https://github.com/cloud-partners/oci-fusion.git
    cd oci-fusion
    ls
    cd terraform1
    ls

That should give you this:

![](./images/01%20-%20git%20clone.png)

## Setup 
The goal is the keep OCI Object Storage data in sync contained in two regions. For replication with WANdisco Fusion, we need to provision at least two servers - one in each region. 

### Buckets and Regions
In this example, we will setup object storage data replication between two OCI regions: us-asburn-1 and us-phoenix-1. 

To configure the software you will need 2 storage containers (buckets). These first 2 buckets will contain the Fusion metadata so lets call this bucket fusion_metadata.  So for each reagion, we must make a bucket with this name. Other storage buckets may contain the actual user data. If these dont exist, you can make them later before you make the replication rules in Fusion.

If you have not set up your user account for use with an S3 API or cli,  make your Customer Secret Keys to create an access key and secret key. This is described [here](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm?Highlight=secretkey#). These extra keys are used as shown below in addition to the user-specific keys you discovered in the pre-req excercise.

Before you perform the terraform provision tasks,  you will need to update the region.tf and variables.tf files with values specific to your account and needs.  Review the variables in this file: terraform1/variables.tf. Again, the variables and where to find them is described in more detail the previous pre-requisite section. Here is list of the variables you will need to supply at this point:

```
### OCI Profile
variable "tenant"               {default = "your_tenancy_name"}  
variable "tenancy_ocid"         {default = "ocid1.tenancy.oc1..key"}
variable "compartment_ocid"     {default = "ocid1.tenancy.oc1..key"}
variable "user_ocid"            {default = "ocid1.user.oc1..key"}
variable "fingerprint"          {default = "key"}

variable "ssh_public_key"       { <your_ssh_public_key> }

# Object Storage
variable "bucket"               {default = "fusion_metadata"}
variable "accesskey"            {default = "ocid1.credential.oc1..key"}           
variable "secretkey"            {default = "your_secret_key"}
variable "endpointurl" {
   type = "map" 
   default = { 
     us-phoenix-1 = "https://<your_tenancy_name>.compat.objectstorage.us-phoenix-1.oraclecloud.com"
     us-ashburn-1 = "https://<our_tenancy_name>.compat.objectstorage.us-ashburn-1.oraclecloud.com"
   }
}
```

## Init
So we now need to initialize the each directory with the modules in them. This makes the modules aware of the OCI provider.  
You can do this by running these commands:

    cd ../terraform1
    terraform init

    cd ../terraform2
    terraform init

This gives the following output:

![](./images/02%20-%20terraform%20init.png)


## Plan

Let's make sure the *terraform plan* looks good:


    cd ../terraform1
    terraform plan

    cd ../terraform2
    terraform plan

And this output should look like:

![](./images/03%20-%20terraform%20plan.png)

## Deploy
If that's good as a pre-flight check, we can go ahead and apply the deploy:

    cd ../terraform2
    terraform apply -auto-approve |tee apply.txt

    cd ../terraform2
    terraform apply -auto-approve |tee apply.txt 

The "apply" for each server should take about 2 minutes to run.  Once each process is complete, you'll see something like this:

![](./images/04%20-%20terraform%20apply.png)

Make note of the Public IP and URL for each session. But don't worry, this info is also captured in the apply.txt file or by running `terraform refresh`.

When the `terrafrom apply` task has finished, the infrastructure will be deployed and *cloud-init* scripts run to deploy Fusion on the server.  Those scripts will "wrap up" asynchronously to the server provisioning process, meaning the cloud-init process runs on the servers right after they are booted up for the first time.  So, it'll be a few more minutes (about 3) before the Fusion application is accessible on each server.  

## Connect to the UI
When the `terraform apply` completed, it prints the output - a few lines about each server: (1) the URL to access the Fusion UI and (2) the Public IP and hostname.  Now that you have waited a few minutes, let's try accessing the UI on port 8083 of the public IP for first server.  You should see this:

![](./images/05%20-%20UI%20login.png)

Now enter in the username and password you specified in [variables.tf](./simple/variables.tf).  You should now see the Fusion Dashboard.

![](./images/06%20-%20Dashboard.png)

At this point the two servers are not yet configured as a replication pair.  We must *induct* the other server to create a dual-zone membership. After that process has completed (takes a minute or two), we can then create the actual replication policies. These are actual rules or definitions of which buckets to replicate.  Fusion will create an proxy server with a virtual object storage bucket that mirrors data into the underlying buckets residing in each region. 

Click on the "Nodes Tab" and then click on the "Induct" Button
And enter the Pubic IP of the *second* server.

![](./images/07%20-%20Induct.png)

## SSH to a Node
These machines are using Oracle Enterprise Linux (OEL).  The default login user is *opc*.  You can SSH into the machine with a command like this:

    ssh -i ~/.ssh/oci opc@<Public IP Address>

Fusion is installed under `/opt/wandisco` and has configuration files under `/etc/wandisco`.
You can debug deployments by investigating the cloud-init output file in the home directory and/or look in `/var/log/messages`.  Note: You'll need to be root, so run `sudo` to be able to read it.

For convenince, on each server you can add the other server name to the hosts file. As generated by the apply task, "tail" the apply.txt files, and cut/paste the IP and hostname. 

Add to the server in Phoenix

     ssh opc@129.146.162.177
     echo "129.213.53.56 fusion-server.ashburn.fusion.oraclevcn.com" | sudo tee -a /etc/hosts

Add to the server in Ashburn

     ssh opc@129.213.53.56
     echo "129.146.162.177 fusion-server.phoenix.fusion.oraclevcn.com" | sudo tee -a /etc/hosts

Add to your own /etc/hosts file (if on say macOS)

     echo "129.146.162.177 fusion-server.phoenix.fusion.oraclevcn.com" | sudo tee -a /etc/hosts
     echo "129.213.53.56   fusion-server.ashburn.fusion.oraclevcn.com" | sudo tee -a /etc/hosts
     
![](./images/08%20-%20ssh.png)

## View the Cluster in the Console
You can also login to the web console [here](https://console.us-ashburn-1.oraclecloud.com/a/compute/instances) to view the IaaS that is running the cluster.
The click on the instance name "fusion_server" to see its details as shown here:

![](./images/09%20-%20console.png)

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it in each directory (terraform1 and terraform2):

    cd ../terraform1
    terraform destroy

    cd ../terraform2
    terraform destroy

You'll need to enter `yes` when prompted.  Once complete, you'll see something like this:

![](./images/10%20-%20terraform%20destroy.png)
