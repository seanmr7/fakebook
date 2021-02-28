class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome_email(resource).deliver unless resource.invalid?
  end
end