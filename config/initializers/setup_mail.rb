ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :domain               => "tmschedule.me",
  :user_name            => "info@tmschedule.me",
  :password             => "cbaf3e82-5279-4448-9a8e-03f4716dffd8",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
