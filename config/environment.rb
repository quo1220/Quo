# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#ActionMailer::Base.smtp_settings = {
#  :user_name => 'apikey',
#  :password => ENV["SENDGRID_PASSWORD"],
#  :domain => "smtp.gmail.com",
#  :address => 'smtp.sendgrid.net',
#  :port => 587,
#  :authentication => :plain,
#  :enable_starttls_auto => true
#}


#ActionMailer::Base.smtp_settings = {
#  :user_name => ENV["SENDGRID_USERNAME"],#'apikey',
#  :password => ENV["SENDGRID_PASSWORD"],
#  :domain =>  "quo2020.herokuapp.com",# "quo2020.herokuapp.com",
#  :address => 'smtp.sendgrid.net',
#  :port => 587,
#  :authentication => :plain,
#  :enable_starttls_auto => true
#}
	