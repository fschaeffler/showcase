Application Load Balancer

Name: showcase
Availability Zones: select all

Assign a security group: Create a new security group
Security group name: showcase-elb

Name: showcase-target-group

Instances: select one showcase instance
Add to registered

Wait for instance to be marked as healthy

Open load balancer url to check it's working


Create Image
Image name: showcase
No reboot: active

click on instance
Launch more like this
Change AMI to created snapshot
select showcase security group

Target Groups: select showcase-target-group
Edit
Instances: select second instance
Add to registered