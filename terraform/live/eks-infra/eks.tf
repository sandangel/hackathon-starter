module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.2"

  cluster_name    = "hackathon-starter"
  cluster_version = "1.24"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  subnet_ids         = module.vpc.private_subnets
  node_group_subnets = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id

  eks_managed_node_groups = {
    eks_nodes = {
      ami_type         = "BOTTLEROCKET_x86_64"
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type        = "t3.medium"
      bootstrap_extra_args = <<-EOT
        # The admin host container provides SSH access and runs with "superpowers".
        # It is disabled by default, but can be disabled explicitly.
        [settings.host-containers.admin]
        enabled = false

        # The control host container provides out-of-band access via SSM.
        # It is enabled by default, and can be disabled if you do not expect to use SSM.
        # This could leave you with no way to access the API and change settings on an existing node!
        [settings.host-containers.control]
        enabled = true

        # extra args added
        [settings.kernel]
        lockdown = "integrity"
      EOT
    }
  }
}
