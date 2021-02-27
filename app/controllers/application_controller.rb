class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
  end

  private

  def only_current_user
    @user = User.find(params[:user_id])
    redirect_to(root_path) unless @user == current_user
  end
end
