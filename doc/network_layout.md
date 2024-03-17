= Network Layout

* this
  * that

= Network Segmentation

== Top Level Networks

The idea here is to have larger network segments where you can apply security policy.  Our recommendation for the top level split is to break it into 2 halves.  The reason for this is to have half the network where it has stricter change policies for production systems or just portions of the network where development and evolution of changes should happen in a more reliable fashion.  The second half of the network would be for non-production systems or areas of the network where change control is less strict because outages due to change are less impactful to your business.

In these top levels it's fairly important to not cross your naming convention with other levels of segmentation.  Because of this we don't want to call them anything like either the long or short names for real network environments like "production" or "prod".  We suggest using something like "prod_net"

These are typically global in nature and cross many regions or even cloud providers.  One might have a segment in gcp with two environments and a segment in aws with two environments where the entire "Top Level Network" could have a single cidr address for reference by a firewall policy.

== Segments

This level of segmentation is where you can group environment segments together.  The largest use case for this is for grouping production blue / green environments togerther.  Some might refer to their second environment as disaster recovery or dr.  This way you can apply security rules to a single network cidr block and be referring to both prod A and prod B in a single rule.

Other uses for this level is to apply rules to uat and qa spoke segments differently than development segments.  Developers might be granted a lot more direct access to resources in dev networks where uat and qa might be restricted to ci/cd modification only.

These are typically region based where a segment might have a couple environments in different regions.  Building on the example in the previous section.  Let's say our segment in question is the "prod_gcp_seg" in gcp.  It would hold one prod environment in us-east1 and a disaster recovery or second prod environment in us-west1.  Remember the name should have it's cloud provider in the name.

== Environments

Our next level are the spokes themselves.  This is where you would typically deploy a "Environment" such as prod, staging, vpn, shared or dev.  We recommend setting up the ability to have 16 of these spokes.  You probably won't use all of them to start out.  But this lets you have room for expansion or evolution of your environments as your business changes.

These are typically zone focused where an environment would exist in a single region but have it's subnets deployed in a VPC with resources across multile availability zones.  Building on the example in the previous section.  Let's say our segment in question is the "prod_gcp_seg" in gcp.  It would hold one prod environment in us-east1 and a disaster recovery or second prod environment in us-west1.  Remember the name should have it's cloud provider in the name.

= Subnets

These are the smallest parts of the network where we recommend deploying a 3 tier network design with one public subnet where devices which require internet IPs can be deployed.  Then a private app subnet which can communicate with the public subnet but does not have NAT access to the internet.  Then a private data subnet with no NAT internet access where it can only talk to the app subnet.  This means attacks from the internet side have to traverse 2 layers of security before accessing data resources.

= Hub + Spoke

The layout we are describing here is intended to be implemented as a hub and spoke model.  The hub network would be rather small but exist in the prod_net for security and change control reasons.  Then all the different environments would be their own spokes.  Routing and firewall policies as well as outbound http proxy filtering would happen on something like a Next Generation FireWall (NGFW) in this hub network.
