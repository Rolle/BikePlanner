Twitter.configure do |config|
  config.consumer_key = "6FzPlhbjJLV1bctMBFusRg"
  config.consumer_secret = "XYx2Cc3YJrRoycehJLOW8PF0WMgwd6DnPg1ntPUIM8"
  config.oauth_token = "587456629-1KLVmpPQvIk6LEeqmkEidcpcJmSK6HIszdtJM7zG"
  config.oauth_token_secret = "K2FHf7LViTYU1p9mDxIwlx8oElPn7svRrWPUryIbE"
  #config.proxy="http://surfproxy.de.db.com:8080/"
end
                                                                                                                                                                                      
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.rolandschmitt.info",
  :port                 => 25,
  #:domain               => 'rolandschmitt.info',
  :user_name            => 'bikeplanner',
  :password             => 'bikeplanner',
  :authentication       => 'plain',
  :enable_starttls_auto => true,
  :openssl_verify_mode  => 'none'
}