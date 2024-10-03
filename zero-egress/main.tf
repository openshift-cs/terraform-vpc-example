data "aws_region" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 5.8.1"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr_block

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = []
  # Tags defined per https://repost.aws/knowledge-center/eks-vpc-subnet-discovery
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  enable_nat_gateway            = false
  enable_dns_hostnames          = true
  enable_dns_support            = true
  manage_default_security_group = false

  tags = {
    Terraform    = "true"
    service      = "ROSA"
    cluster_name = var.cluster_name
  }
}

resource "aws_security_group" "authorize_inbound_vpc_traffic" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_subnets
  }
  vpc_id = module.vpc.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/vpc-endpoints.html
resource "aws_vpc_endpoint" "sts" {
  service_name      = "com.amazonaws.${var.region}.sts"
  vpc_id            = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.authorize_inbound_vpc_traffic.id]

  tags = {
    Terraform    = "true"
    service      = "ROSA"
    cluster_name = var.cluster_name
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_id            = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.authorize_inbound_vpc_traffic.id]

  tags = {
    Terraform    = "true"
    service      = "ROSA"
    cluster_name = var.cluster_name
  }
}

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/vpc-endpoints.html
resource "aws_vpc_endpoint" "ecr_dkr" {
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_id            = module.vpc.vpc_id
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.authorize_inbound_vpc_traffic.id]

  tags = {
    Terraform    = "true"
    service      = "ROSA"
    cluster_name = var.cluster_name
  }
}

# https://docs.aws.amazon.com/vpc/latest/privatelink/vpc-endpoints-s3.html
resource "aws_vpc_endpoint" "s3" {
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_id            = module.vpc.vpc_id
  vpc_endpoint_type = "Gateway"

  # Associate with route tables instead of subnets
  route_table_ids = module.vpc.private_route_table_ids

  tags = {
    Terraform    = "true"
    service      = "ROSA"
    cluster_name = var.cluster_name
  }
}
