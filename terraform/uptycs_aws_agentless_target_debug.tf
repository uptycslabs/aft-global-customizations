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
  additional_tags    = local.uptycs_aws_agentless_target.additionalTags
}
