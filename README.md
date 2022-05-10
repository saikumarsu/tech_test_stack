# EKS cluster creation and webApp deployment

**Usage**

This stack creates basic network infrastructure (VPCs/Subnets/NAT Gateways etc.), EKS cluster, associated IAM roles/policies to enable kubectl access from workstation/cloud9 IDE. Also will be testing a basic web app deployment.

**Pre-requisites**

Following tools configured in cloud9 IDE/laptop

1. Kubectl
2. Terraform
3. Docker
4. IAM authenticator
5. Git client 

**Base network creation**

- Local backend configured for terraform statefiles
- provider configuration for the associated tools
- initialise tf, plan and apply 01_eks_vpc.tf to create the base network. This created the VPC, public subnet and private subnets.

**EKS Cluster creation**

- 02_eks_cluster.tf & 03_eks_nodes.tf is uing public modules to create the eks cluster in eu-west-1 region. for testing purposes, configured a 2 worker (blue/green) node cluster.






**IAM role and Security groups**

- 03_eks_role.tf is updated with IAM role and security group config




Sample web app deployment

One of the java web app is configured to test the deployment, this is recommended to deploy the services through CICD/Helm charts. In this the job is configured as terraform resource block is called to deply the microservice. Created the docker image and pushed to docker hub as the container registery.
High availability purposes there are 2 replicas deployed and this can be autoscaled.


11_web_app.tf

![image](https://user-images.githubusercontent.com/34026320/167369367-149f23e6-531a-4063-a0a3-c1180c24fe1d.png)

![image](https://user-images.githubusercontent.com/34026320/167369471-170615ee-f30b-43bb-be71-aa809ed5cc0a.png)


Checking the deployment status

![image](https://user-images.githubusercontent.com/34026320/167370061-a68f45d2-6ae1-4ad5-b9ad-06ce5373c75e.png)

And the web interface is accessable via internet facing loadbalancer (testing purposes), this is recommended to configure loadbalancer via R53 domain naming and API gateways. Also should be configured over secure protocol/https

![image](https://user-images.githubusercontent.com/34026320/167370721-e6db7417-9150-4e6e-877d-42f4a445e530.png)


# Service monitoring (Prometheus, Garafana, Alertmanager)

The monitoring tools are deployed theiugh helm charts, and are copied in the respective directories. 



These services are deployed under a seperate namespace 'monitoring'


The web interface is not exposed to public internet, and is accessable form the workspace.




Exporter configuration and specific alert status code extraction is pending, facing some issues provisioning the persistant storage to pods. Will work and get this sorted.



