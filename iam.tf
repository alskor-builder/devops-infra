resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


###user role not working dont have permissions
# resource "aws_iam_role" "user_eks_access_role" {
#   name = "user-eks-access-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           AWS = "arn:aws:iam::411202742861:user/devops-exam"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "user_eks_policy" {
#   role       = aws_iam_role.user_eks_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy_attachment" "user_eks_vpc_resource_policy" {
#   role       = aws_iam_role.user_eks_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
# }

# resource "aws_iam_policy" "user_assume_role_policy" {
#   name        = "UserAssumeEksClusterRole"
#   description = "Allows user to assume EKS cluster role"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = "sts:AssumeRole",
#         Resource = aws_iam_role.user_eks_access_role.arn
#       }
#     ]
#   })
# }

# resource "aws_iam_user_policy_attachment" "user_assume_role_attachment" {
#   user       = "devops-exam"
#   policy_arn = aws_iam_policy.user_assume_role_policy.arn
# }