class UserMailer < ApplicationMailer
  default from: 'notifications@hidden-fortress-73284.herokuapp.com/.com'

  def welcome_email(resource)
    @user = resource
    mail(to: @user.email, subject: 'Welcome to Fakebook!')
  end
end
