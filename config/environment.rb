# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'nryberg',
  :password             => 'zoogle4',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }

# Initialize the rails application
ToastSchedule::Application.initialize!
