if Rails.env != 'production'
  email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
  ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
else
  ActionMailer::Base.default_url_options[:host] = "www.tmschedule.me"
end

