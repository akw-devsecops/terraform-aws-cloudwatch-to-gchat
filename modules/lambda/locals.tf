locals {
  module_name = "aws-cw-to-gchat-${local.chat_space_id}"
}

locals {
  pattern       = "(?:spaces/)(?P<space>.*)(?:/messages)"
  match         = regex(local.pattern, var.google_chat_url)
  chat_space_id = local.match["space"]
}
