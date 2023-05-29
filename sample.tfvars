region               = "us-east-1"
subnet_azs           = ["use1-az2", "use1-az4", "use1-az6"]
cluster_name         = "rosa-hcp-${substr(base64encode(uuid()), 0, 6)}"
vpc_cidr             = "10.0.0.0/16"
subnet_cidr_prefix   = 24
private_subnets_only = false
single_az_only       = false
