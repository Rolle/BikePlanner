# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
Bikeplanner::Application.initialize!
module MailEnv
  SEND_NOTIFICATION_EMAIL = true 
end
module TwitterEnv
  SEND_TWITTER_STATUS = true
end