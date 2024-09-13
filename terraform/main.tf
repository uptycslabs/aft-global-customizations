provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "aft_role_tf" {
  name = "RoleCreateByAFT"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "aft_role_tf_policy" {
  role = aws_iam_role.aft_role_tf.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "s3:ListBucket"
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}
