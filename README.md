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

The following requirements are needed by this module:

- terraform (>= 1.4.0)

- aws (~> 4.0)

- null (~> 3.2)

## Providers

The following providers are used by this module:

- aws (4.67.0)

- null (3.2.1)

## Modules

The following Modules are called:

### vpc

Source: terraform-aws-modules/vpc/aws

Version: ~> 4.0.0

## Resources

The following resources are used by this module:

- [null_resource.validations](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [aws_availability_zones.available_azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) (data source)

## Required Inputs

The following input variables are required:

### region

Description: Region to create AWS infrastructure resources for a  
  ROSA with hosted control planes cluster. (required)

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### cluster\_name

Description: Name of the created ROSA with hosted control planes cluster.

Type: `string`

Default: `"rosa-hcp"`

### private\_subnets\_only

Description: Only create private subnets

Type: `bool`

Default: `false`

### single\_az\_only

Description: Only create subnets in a single availability zone

Type: `bool`

Default: `true`

### subnet\_azs

Description: List of availability zone names or IDs that subnets can get deployed into.  
  If not provided, defaults to well known AZ IDs for each region.  
  Does not currently support Local Zones, Outpost, or Wavelength.

Type: `list(string)`

Default: `[]`

### subnet\_cidr\_prefix

Description: The CIDR prefix value to use when dividing up the VPC CIDR range into subnet ranges.  
  E.g., 24 to create equal subnets of size "24": 10.0.1.0/24, 10.0.2.0/24, etc.

Type: `number`

Default: `24`

### vpc\_cidr

Description: IPv4 CIDR netmask for the VPC resource.  
  This should equal or include the cluster's Machine CIDR netmask.

Type: `string`

Default: `"10.0.0.0/16"`

## Outputs

The following outputs are exported:

### cluster-private-subnets

Description: List of private subnet IDs created

### cluster-public-subnets

Description: List of private subnet IDs created