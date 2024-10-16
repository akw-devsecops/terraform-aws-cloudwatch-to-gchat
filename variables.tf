variable "notification_setup" {
  type = list(object({
    sns_topic_arns   = list(string)
    google_chat_urls = list(string)
  }))
  description = <<-EOT
    A list of connection relations to connect sns topics with google chat rooms. Each relation can contain multiple sns topics and multiple google chat urls.
    Each relation object will connect all sns topics with all google chat urls.
    The endpoints of google chat webhooks (urls) must begin with `https://`.
    The ARNs of the sns topics to subscribe to (e.g. `arn:aws:sns:eu-central-1:1234567890:example-topic`).
  EOT
}

variable "time_zone" {
  type        = string
  description = "The timezone in which a timestamp should be displayed. See (https://lonewolfonline.net/timezone-information/#toc_list-net-timezone-values)"
  default     = "W. Europe Standard Time"
}

variable "culture_info" {
  type        = string
  description = "The country and culture format in which a timestamp should be displayed. See (https://learn.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo)"
  default     = "de-DE"
}

variable "env" {
  type        = string
  description = "The environment of the application"
}
