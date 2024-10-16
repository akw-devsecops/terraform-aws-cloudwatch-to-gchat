# AWS Cloudwatch Alert to Google Chat Module

Terraform Module to set up Google Chat Notifications for AWS Cloudwatch Alerts. Currently, only SNS messages from Cloudwatch Alerts are supported.

This module will only subscribe to existing SNS Topics and existing Google Chat webhooks.

The Cloudwatch Alerts, SNS Topics and Google Chat webhooks must be setup separately.

## Simple Subscription Example

```terraform
# Create example SNS topic
resource "aws_sns_topic" "example" {
  name = "example-sns-topic"
}

# Add sns subscription and google chat webhook as target
module "cloudwatch_to_gchat" {
  source  = "akw-devsecops/cloudwatch-to-gchat/aws"
  version = "1.0.0"

  env = "dev"
  
  notification_setup = [
    {
      sns_topic_arns   = [aws_sns_topic.example.arn]
      google_chat_urls = [
        "https://chat.googleapis.com/v1/spaces/XXXXXXXXXXX/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ]
    }
  ]
}

# TODO: Create a cloudwatch alarm in the AWS management console, via the AWS cli or terraform.
# TODO: Setup the cloudwatch alarm to send notifications to the newly created or existing SNS topic.
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_setup"></a> [lambda\_setup](#module\_lambda\_setup) | ./modules/lambda | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The environment of the application | `string` | n/a | yes |
| <a name="input_notification_setup"></a> [notification\_setup](#input\_notification\_setup) | A list of connection relations to connect sns topics with google chat rooms. Each relation can contain multiple sns topics and multiple google chat urls.<br>Each relation object will connect all sns topics with all google chat urls.<br>The endpoints of google chat webhooks (urls) must begin with `https://`.<br>The ARNs of the sns topics to subscribe to (e.g. `arn:aws:sns:eu-central-1:1234567890:example-topic`). | <pre>list(object({<br>    sns_topic_arns   = list(string)<br>    google_chat_urls = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_culture_info"></a> [culture\_info](#input\_culture\_info) | The country and culture format in which a timestamp should be displayed. See (https://learn.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo) | `string` | `"de-DE"` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | The timezone in which a timestamp should be displayed. See (https://lonewolfonline.net/timezone-information/#toc_list-net-timezone-values) | `string` | `"W. Europe Standard Time"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Docs

To update the docs just run

```shell
terraform-docs .
```
