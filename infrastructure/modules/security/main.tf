# EKS cluster roles and policies

resource "aws_iam_role" "eks-cluster-role" {
  name               = "${var.APP_NAME}-eks-cluster-role-${var.STAGE}"
  assume_role_policy = file("${path.module}/templates/eks-cluster-role.json.tpl")
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

# EKS node group roles and policies

resource "aws_iam_role" "eks-node-group-role" {
  name               = "${var.APP_NAME}-eks-node-group-role-${var.STAGE}"
  assume_role_policy = file("${path.module}/templates/eks-ec2-role.json.tpl")
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-cni-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "ecr-readonly-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}
