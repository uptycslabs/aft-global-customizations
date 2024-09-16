locals {
  uptycs_aws_agentless_target = {
    integrationPrefix  = "girionpremtf"
    scannerAccountId   = "794888992839"
  }  // Update above values as required
}

module "uptycs_aws_agentless_target" {
  source = "https://uptycs-terraform-dev.s3.amazonaws.com/terraform-aws-uptycs.zip//modules/agentless_integration/target"

  integration_prefix = local.uptycs_aws_agentless_target.integrationPrefix
  scanner_account_id = local.uptycs_aws_agentless_target.scannerAccountId
}

/*
// Below is manual way of creating role which defined permissions
resource "aws_iam_role" "upt_aws_agentless_target" {
  name = "${local.uptycs_aws_agentless_target.integrationPrefix}-agentless-target"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${local.uptycs_aws_agentless_target.scannerAccountId}:root"
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
            "aws:ResourceTag/CreatedByUptycs" = "${local.uptycs_aws_agentless_target.integrationPrefix}-agentless"
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
*/
