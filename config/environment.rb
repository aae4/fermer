# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fermer::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 587,
  :user_name  => "vsakiispam@gmail.com",
  :password  => "o0vu7ofir",
  :authentication  => "plain"
}
