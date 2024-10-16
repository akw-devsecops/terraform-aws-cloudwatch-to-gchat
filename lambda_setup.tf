module "lambda_setup" {
  for_each = {
    for index, item in local.final_notification_setup :
    index => item
  }

  source = "./modules/lambda"

  google_chat_url = each.value.URL
  sns_topic_arns  = each.value.SNS

  time_zone    = var.time_zone
  culture_info = var.culture_info

  env = var.env
}
