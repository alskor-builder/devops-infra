# AWS EKS Cluster Deployment

This Terraform project automates the deployment of an Amazon EKS (Elastic Kubernetes Service) cluster. It includes configurations for networking, security groups, IAM roles, and the Kubernetes cluster itself, structured for ease of deployment and management in the AWS cloud.

## Terraform Configuration Files

- `backend.tf`: Configures AWS S3 as the backend for storing the Terraform state file.
- `eks.tf`: Defines the resources for deploying the EKS cluster.
- `iam.tf`: Sets up the necessary IAM roles for the EKS cluster.
- `security-group.tf`: Establishes security groups for the EKS cluster.
- `vpc.tf`: Configures the VPC, subnets, and networking resources.

## Infrastructure Overview

### EKS Cluster (`eks.tf`)
- **Cluster Name**: `my-cluster-1`
- **Kubernetes Version**: `1.27`
- **Node Group Configuration**:
  - **Instance Type**: `t3.small`
  - **Scaling**: 1 minimum, 2 desired, 3 maximum instances

### Security Groups (`security-group.tf`)
- **EKS Cluster Security Group**:
  - Permits all inbound traffic on port 80 from any source (0.0.0.0/0).

### IAM Role for EKS Cluster (`iam.tf`)
- **EKS Cluster Role**:
  - **Role Name**: `eks-cluster-role-1`
  - Allows EKS service to manage clusters on your behalf.

### VPC Configuration (`vpc.tf`)
- **VPC CIDR**: `10.0.0.0/16`
- **Subnets**:
  - Public Subnets: `10.0.1.0/24`, `10.0.2.0/24`
  - Private Subnets: `10.0.3.0/24`, `10.0.4.0/24`
- **NAT Gateways**: Enabled to allow outbound internet access from the private subnets.


## GitHub Actions Automation

### [CI/CD Documentation](CICD_README.md)

*** Security Considerations
Review and restrict the ingress rules in the security group configuration to match your network policies.