class MemberMailer < ActionMailer::Base
  default from: "tmschedule@rybergs.com"
  default to: "demo_account@rybergs.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.password_reset.subject
  #
  def password_reset(member)
    @greeting = "Hi"
    @member = member

    mail :to => member.email, :subject => "Password Reset Request"
  end

  def welcome_confirm_new_user(member)
    @member = member

    @validate_url = "/validate/#{@member.validation_token}"

    mail :subject => "Welcome to TM Schedule!"
  end
end
