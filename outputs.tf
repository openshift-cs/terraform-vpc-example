output "cluster-private-subnets" {
  value       = module.vpc.private_subnets
  description = "List of private subnet IDs created"
}

output "cluster-public-subnets" {
  value       = module.vpc.public_subnets
  description = "List of private subnet IDs created"
}
