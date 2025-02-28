# Zero Egress Terraform VPC Example

This repository contains Terraform configurations to set up a Disconnected AWS Virtual Private Cloud (VPC) for use with Red Hat OpenShift Service on AWS (ROSA) Hosted Control Planes (HCP) cluster with zero egress. This setup ensures that all cluster traffic remains within the AWS network, eliminating the need for internet access (egress) for the cluster.

## Features

- **Zero egress configuration:** All network traffic for the ROSA HCP cluster is restricted to the AWS VPC.
- **Customizable networking:** Allows for flexible configuration of subnets, route tables, and security groups.
- **Automated setup:** Utilizes Terraform to automate the creation and configuration of the VPC and associated resources.

## Prerequisites

Before you begin, ensure that you have the following:

- [Terraform](https://www.terraform.io/downloads.html) 1.8.5 or later installed
- AWS CLI configured with proper permissions to manage VPC, subnets, and other resources

## Usage

### Planning

- Simple usage

        $ terraform plan -out rosa-zero-egress.tfplan -var region=us-east-2

- Full usage with command line variable

        $ terraform plan -out rosa-zero-egress.tfplan \
            -var region=us-west-2 \
            -var 'availability_zones=["us-west-2a", "us-west-2b", "us-west-2c"]' \
            -var cluster_name=rosa-zero-egress \
            -var vpc_cidr_block=10.0.0.0/16 \
            -var 'private_subnets=["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]'


- Full usage with sample tfvars file

        $ terraform plan -out rosa-zero-egress.tfplan -var-file=sample.tfvars

### Apply

    $ terraform apply rosa-zero-egress.tfplan

### **Review Outputs:**

   After the apply, Terraform will output the necessary VPC details such as VPC ID, private subnet IDs, and security group IDs. These values will be used when deploying the ROSA HCP cluster.

### Cleanup

To destroy the resources created by this Terraform configuration, run:

```bash
terraform destroy
```

## Reference

### Variables

| Name               | Description                                            | Type   | Default |
|--------------------|--------------------------------------------------------|--------|---------|
| `vpc_cidr_block`    | CIDR block for the VPC                                 | string | `10.0.0.0/16` |
| `private_subnets`   | List of CIDR blocks for the private subnets             | list   | `["10.0.1.0/24", "10.0.2.0/24"]` |
| `availability_zones`| List of AWS availability zones for the private subnets | list   | `["us-west-2a", "us-west-2b"]` |
| `region`            | AWS region where the resources will be deployed        | string | `us-west-2` |
| `cluster_name`      | Cluster Name                                           | string | `my-cluster-01` |

### Outputs

The following outputs are provided after successful deployment:

- `vpc_id`: The ID of the VPC.
- `private_subnet_ids`: List of private subnet IDs.

