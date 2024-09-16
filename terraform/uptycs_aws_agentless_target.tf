resource "aws_iam_role" "upt_aws_agentless_target" {
  name = "girionpremtf-agentless-target"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::794888992839:root"
      }
      Action = "sts:AssumeRole"
      Condition = {}
    }]
  })
}

resource "aws_iam_role_policy" "upt_aws_agentless_target_policy" {
  role = aws_iam_role.upt_aws_agentless_target.id
  name = "UptycsAgentlessTargetPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateSnapshot",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:CopySnapshot"
        ]
        Resource = "*"
        Effect = "Allow"
      },
      {
        Condition = {
          "ForAllValues:StringEquals" = {
            "ec2:CreateAction" = [
              "CreateSnapshot",
              "CopySnapshot"
            ]
          }
        }
        Action = "ec2:CreateTags"
        Resource = "arn:aws:ec2:*::snapshot/*"
        Effect = "Allow"
      },
      {
        Condition = {
          "StringEquals" = {
            "aws:ResourceTag/CreatedByUptycs" = "girionpremtf-agentless"
          }
        }
        Action = [
          "ec2:ModifySnapshotAttribute",
          "ec2:DeleteSnapshot",
          "ec2:DeleteTags",
          "ec2:CreateTags"
        ]
        Resource = "*"
        Effect = "Allow"
      },
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:RetireGrant",
          "kms:ListGrants",
          "kms:CreateGrant"
        ]
        Resource = [
          "arn:aws:kms:*:*:key/*"
        ]
        Effect = "Allow"
      }
    ]
  })
}
