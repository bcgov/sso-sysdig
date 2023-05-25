resource "sysdig_monitor_notification_channel_webhook" "rocketchat-webhook" {
  name                   = "Rocket chat alert webhoot"
  enabled                = true
  url                    = var.rocket_chat_webhook
  notify_when_ok         = true
  notify_when_resolved   = true
  send_test_notification = false
}
