#CREATING IAM ROLE

resource "aws_iam_role" "demo-cluster" {
  name = "terraform-eks-demo-cluster"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmaoznEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.demo-cluster.name
}


resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSServicePolicy"{
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
   role = aws_iam_role.demo-cluster.name
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSVPCResourceController"{
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
   role = aws_iam_role.demo-cluster.name
}

