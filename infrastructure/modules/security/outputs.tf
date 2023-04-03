output "eks-cluster-role-arn" {
  value = aws_iam_role.eks-cluster-role.arn
}

output "eks-node-group-role-arn" {
  value = aws_iam_role.eks-node-group-role.arn
}
