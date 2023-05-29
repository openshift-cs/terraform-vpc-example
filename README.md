# ROSA Reference VPC

# Usage

## Planning

- Simple usage

        $ terraform plan -out rosa.tfplan -var region=us-east-2

- Full usage with command line variable

        $ terraform plan -out rosa.tfplan \
            -var region=us-east-2 \
            -var 'subnet_azs=["use2-az1", "use2-az2", "use2-az3"]' \
            -var cluster_name=rosa-hcp \
            -var vpc_cidr=10.0.0.0/16 \
            -var subnet_cidr_prefix=24 \
            -var private_subnets_only=false \
            -var single_az_only=false


- Full usage with sample tfvars file

        $ teraform plan -out rosa.tfplan -var-file=sample.tfvars

## Apply

    $ terraform apply rosa.tfplan

# Reference

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4.0 |
| aws | ~> 4.0 |
| null | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| aws | 4.67.0 |
| null | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | terraform-aws-modules/vpc/aws | ~> 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.validations](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_availability_zones.available_azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the created ROSA with hosted control planes cluster. | `string` | `"rosa-hcp"` | no |
| private\_subnets\_only | Only create private subnets | `bool` | `false` | no |
| region | Region to create AWS infrastructure resources for a<br>  ROSA with hosted control planes cluster. (required) | `string` | n/a | yes |
| single\_az\_only | Only create subnets in a single availability zone | `bool` | `true` | no |
| subnet\_azs | List of availability zone names or IDs that subnets can get deployed into.<br>  If not provided, defaults to well known AZ IDs for each region.<br>  Does not currently support Local Zones, Outpost, or Wavelength. | `list(string)` | `[]` | no |
| subnet\_cidr\_prefix | The CIDR prefix value to use when dividing up the VPC CIDR range into subnet ranges.<br>  E.g., 24 to create equal subnets of size "24": 10.0.1.0/24, 10.0.2.0/24, etc. | `number` | `24` | no |
| vpc\_cidr | IPv4 CIDR netmask for the VPC resource.<br>  This should equal or include the cluster's Machine CIDR netmask. | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster-private-subnets | List of private subnet IDs created. |
| cluster-public-subnets | List of private subnet IDs created. |
| cluster-subnets-string | Comma-separated string of all subnet IDs created for this cluster. |