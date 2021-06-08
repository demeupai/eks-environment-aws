module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = var.eks-version
  subnets         = module.vpc.private_subnets

  tags = {
    "Environment" = var.environment
    "App"         = var.application
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = var.eks-worker-group-name-one
      instance_type                 = var.eks-instance-type-group-one
      asg_desired_capacity          = var.eks-worker-group-one-capacity
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = var.eks-worker-group-name-two
      instance_type                 = var.eks-instance-type-group-two
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = var.eks-worker-group-two-capacity
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
