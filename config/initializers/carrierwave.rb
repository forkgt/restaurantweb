CarrierWave.configure do |config|
  config.dropbox_app_key = APP_CONFIG["app_key"]
  config.dropbox_app_secret = APP_CONFIG["app_secret"]
  config.dropbox_access_token = APP_CONFIG["access_token"]
  config.dropbox_access_token_secret = APP_CONFIG["access_token_secret"]
  config.dropbox_user_id = APP_CONFIG["user_id"]
  config.dropbox_access_type = "dropbox"
end