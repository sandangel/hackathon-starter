# Terraform Infrastructure Overview

This document provides an overview of the infrastructure setup using Terraform, referencing the infrastructure diagram for clarity.

## Infrastructure Components

### AWS VPC
- **VPC**: A Virtual Private Cloud (VPC) is created to host the infrastructure, providing isolated networking.
- **Subnets**: The VPC includes both public and private subnets across multiple availability zones for high availability. The network is designed to allocate more IPs to private subnets than public subnets, as public subnets are only used for load balancers, while private subnets handle all workloads and nodes, optimizing for internal communication and resource allocation.

### EKS Cluster
- **EKS**: An Elastic Kubernetes Service (EKS) cluster is deployed within the VPC, allowing for scalable container orchestration.
- **Node Groups**: Managed node groups are configured to run workloads, with settings for desired, minimum, and maximum capacity.

### Load Balancers
- **Public Subnets**: Load balancers are deployed in public subnets to distribute incoming traffic to the EKS cluster.

### Terraform State Management
- **S3 Bucket**: An S3 bucket is used to store the Terraform state files securely.
- **DynamoDB Table**: A DynamoDB table is used for state locking to prevent concurrent modifications.

## Infrastructure Diagram

Refer to the `infrastructure-diagram.md` for a visual representation of the setup, illustrating the relationships between components such as the VPC, subnets, EKS cluster, and load balancers.
