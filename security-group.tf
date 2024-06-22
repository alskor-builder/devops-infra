resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg-1"
  description = "Security group for all nodes in the cluster"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "eks_cluster_ingress" {
  description = "Allow necessary inbound traffic for EKS"
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}