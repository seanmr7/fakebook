class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(resource)
    @user = resource
    mail(to: @user.email, subject: 'Welcome to Fakebook!')
  end
end
