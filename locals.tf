locals {
  cartesian_product_of_connections = [
    for item in var.notification_setup : setproduct(item.google_chat_urls, item.sns_topic_arns)
  ]
  flattened_cartesian_product = concat(local.cartesian_product_of_connections...)
  unique_combinations         = toset(local.flattened_cartesian_product)
  grouped_sns_topics          = { for item in local.unique_combinations : item[0] => item[1]... }
  final_notification_setup = [
    for key, value in local.grouped_sns_topics : {
      URL = key, SNS = { for index, item in value : "SNS${index}" => item }
    }
  ]
}
