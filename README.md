# EKS cluster creation and webApp deployment

**1.1. Usage**

This stack creates basic network infrastructure (VPCs/Subnets/NAT Gateways etc.), EKS cluster, associated IAM roles/policies to enable kubectl access from workstation/cloud9 IDE. Also will be testing a basic web app deployment.

**1.2. Pre-requisites**

Following tools configured in cloud9 IDE/laptop

1. Kubectl
2. Terraform
3. Docker
4. IAM authenticator
5. Git client 

**1.3. Base network creation**

[backend.tf]Local backend configured for terraform statefiles 
[provider.tf]provider configuration for the associated tools 

[01_eks_vpc.tf] VPC/Subnets/IG/Routing Table/Routing table configs 
- initialise terraform, plan and apply to create the base network resources including public subnet and private subnets.

**1.4. EKS Cluster creation**

[02_eks_cluster.tf] - Creates IAM role/policies, cluster security groups, and EKS lsuter
[03_eks_nodes.tf] - Creates IAM roles/polices for node groups, private keys for nodes groups and eks node groups
[04-output.tf] - Creates configmap and auth configs for the cluster
[05-iam-role.tf] - This is optional depending on where the kubectl is running and how needs to manage the eks cluster resource. I'm uing cloud9 instance and attach this role to manage the eks cluster resources running in the same aws account.


**1.5 Deploy Sample WebApp**

[06_web_app.tf] - Sample web app deployment

One of the java web app is configured to test the deployment, this is recommended to deploy the services through CICD/Helm charts. In this the job is configured as terraform resource block is called to deply the microservice. Created the docker image and pushed to docker hub as the container registery.
High availability purposes there are 2 replicas deployed and this can be autoscaled.


![image](https://user-images.githubusercontent.com/34026320/167369367-149f23e6-531a-4063-a0a3-c1180c24fe1d.png)

![image](https://user-images.githubusercontent.com/34026320/167369471-170615ee-f30b-43bb-be71-aa809ed5cc0a.png)


Checking the deployment status

![image](https://user-images.githubusercontent.com/34026320/167370061-a68f45d2-6ae1-4ad5-b9ad-06ce5373c75e.png)

And the web interface is accessable via internet facing loadbalancer (testing purposes), this is recommended to configure loadbalancer via R53 domain naming and API gateways. Also should be configured over secure protocol/https

![image](https://user-images.githubusercontent.com/34026320/167370721-e6db7417-9150-4e6e-877d-42f4a445e530.png)


# Service monitoring (Prometheus, Garafana, Alertmanager)

**2.1 Storage configuration based on AWS EFS**

[07_eks_efs.tf] - Created EFS storage, iam roles, security groups to access the efs storage and creates access point.

- Deploy EFS CSI driver 

  helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
  helm repo update
  helm upgrade --install aws-efs-csi-driver --namespace kube-system aws-efs-csi-driver/aws-efs-csi-driver


[08_efs_provider.tf] - efs endpoint out defined

[09_efs_rbac.tf] - cluster role binding to the nfs provisioner

[10_efs_provisioner.tf] - creates service and runs in the EKS to check of the available persistance storage and binds to the containers

[11_pvcreate.yaml] - Creates persistance volume for data high availability, in the event of pod restarts/moving to different eks nodes, the data will be persistant. 

**2.2 Promethus service deployment**

[12_prometheus.tf] - This created persistance volume claim for prometheus pods, configMap for teh service, deployment spec and prometheus service deployment

On successfull deployment, prometheus service will be accessable through external alb url

![image (1)](https://user-images.githubusercontent.com/34026320/167835672-5dccdd4e-55f1-434a-b6ab-6eb7d77ce014.png)


Alert monitoring configured for the pods -

![image](https://user-images.githubusercontent.com/34026320/167835436-1b26f73c-6abb-4784-a190-bf50d24bffa0.png)

- Kube state matics configuration
  git clone https://github.com/devopscube/kube-state-metrics-configs.git
  kubectl apply -f kube-state-metrics-configs/
  
  ![image](https://user-images.githubusercontent.com/34026320/167894427-aea19693-cf06-45c3-b4d0-696c73d9c05e.png)

  
**2.3 Grafana service deployment**

[grafana.yaml] Created persistent volume claim, deployment spec and deploys service deployment yaml

Web url can be accessed on external loadbalancer dns, recommended to add in R53 custom dns.

![image](https://user-images.githubusercontent.com/34026320/167907283-cb6fde42-8532-442c-8dc5-3ace1a339cab.png)


**2.4 Integrate with prometheus and create dashboard**

Integrate prometheus alerts to grafa using the prometheus internal IP and application port, enable GET API.

![image](https://user-images.githubusercontent.com/34026320/167902532-6870c2f0-fef6-449c-965a-4e739884f4c9.png)

![image (1)](https://user-images.githubusercontent.com/34026320/167835672-5dccdd4e-55f1-434a-b6ab-6eb7d77ce014.png)

