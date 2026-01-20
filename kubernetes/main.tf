provider "aws" {
  region = "eu-west-1"
}

resource "aws_eks_cluster" "infoline_cluster" {
  name      = "infoline-eks"
  role_arn  = aws_iam_role.eks_role.arn


  vpc_config {
    subnet_ids = ["subnet-07b6a6bfe69fa5cc4", "subnet-08184cecb098162b0"]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]  
  })
}
