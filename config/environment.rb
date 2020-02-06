# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
ActionMailer::Base.smtp_settings = {
  :user_name => 'imoris',
  :password => 'Maybel12@',
  :domain => 'localhost',
  :address => 'smtp.sendgrid.net',
  :port => 465,
  :authentication => :plain,
  :enable_starttls_auto => true
}
Rails.application.initialize!
