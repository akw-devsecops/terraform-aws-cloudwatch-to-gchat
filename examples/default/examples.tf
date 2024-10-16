provider "aws" {
  region = "eu-central-1"
}

module "setup" {
  source = "../.."

  env = "dev"

  notification_setup = [
    {
      sns_topic_arns   = ["arn:aws:sns:eu-central-1:123456789000:example-topic-1"]
      google_chat_urls = [
        "https://chat.googleapis.com/v1/spaces/XXXXXXXXXXX/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
        "https://chat.googleapis.com/v1/spaces/YYYYYYYYYYY/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ]
    },
    {
      sns_topic_arns = [
        "arn:aws:sns:eu-central-1:123456789000:example-topic-2",
        "arn:aws:sns:eu-central-1:123456789000:example-topic-3"
      ]
      google_chat_urls = [
        "https://chat.googleapis.com/v1/spaces/YYYYYYYYYYY/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
        "https://chat.googleapis.com/v1/spaces/ZZZZZZZZZZZ/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ]
    }
  ]

  culture_info = "en-US"
  time_zone    = "Central Europe Standard Time"
}

module "minimal_setup" {
  source = "../.."

  env = "dev"

  notification_setup = [
    {
      sns_topic_arns   = ["arn:aws:sns:eu-central-1:123456789000:example-topic-1"]
      google_chat_urls = [
        "https://chat.googleapis.com/v1/spaces/XXXXXXXXXXX/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ]
    }
  ]
}
