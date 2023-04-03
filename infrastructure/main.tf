module "vpc" {
  source = "./modules/network"

  APP_NAME   = var.APP_NAME
  STAGE      = var.STAGE
  AWS_REGION = var.AWS_REGION
}

module "security" {
  source = "./modules/security"

  APP_NAME = var.APP_NAME
  STAGE    = var.STAGE
}

module "cluster" {
  source = "./modules/cluster"

  APP_NAME                               = var.APP_NAME
  STAGE                                  = var.STAGE
  PUBLIC_SUBNET_IDS                      = module.vpc.public-subnet-ids
  PRIVATE_SUBNET_IDS                     = module.vpc.private-subnet-ids
  EKS_CLUSTER_IAM_ROLE                   = module.security.eks-cluster-role-arn
  EKS_NODE_GROUP_IAM_ROLE                = module.security.eks-node-group-role-arn
  EKS_CLUSTER_IAM_POLICY_ATTACHMENT      = module.security.eks-cluster-role-policy-attachment
  EKS_WORKER_NODES_POLICY_ATTACHMENT     = module.security.eks-node-group-policy-attachment
  EKS_WORKER_NODES_CNI_POLICY_ATTACHMENT = module.security.eks-node-group-cni-policy-attachment
  EKS_ECR_POLICY_ATTACHMENT              = module.security.eks-ecr-policy-attachment
}
