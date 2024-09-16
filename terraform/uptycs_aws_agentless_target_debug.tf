locals {
  integrationPrefix  = "girionpremtf-debug"
  scannerAccountId   = "794888992839"
  additionalTags     = {}
}  // Update above values as required

module "uptycs_aws_agentless_target" {
  source = "https://uptycs-terraform-dev.s3.amazonaws.com/terraform-aws-uptycs.zip//modules/agentless_integration/target"

  integration_prefix = local.integrationPrefix
  scanner_account_id = local.scannerAccountId
  additional_tags    = local.additionalTags
}
