ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "rybergs.com",
  :user_name            => "tmschedule@rybergs.com",
  :password             => "QVgxpd42oMPt",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
