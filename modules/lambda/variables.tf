variable "google_chat_url" {
  type        = string
  description = "Endpoint of google chat webhook to send data to URL beginning with `https://`."
}

variable "sns_topic_arns" {
  type        = map(string)
  description = "A map of ARNs of the SNS topics to subscribe to (e.g. `arn:aws:sns:eu-central-1:1234567890:example-topic`)."
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
