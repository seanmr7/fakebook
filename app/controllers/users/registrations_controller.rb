class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    # Disabling welcome emails while waiting to resolve an issue with Mailgun email service
    #UserMailer.welcome_email(resource).deliver unless resource.invalid?
  end
end