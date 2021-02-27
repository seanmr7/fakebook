class ProfilesController < ApplicationController
  before_action :only_current_user
  
  def new
    @profile = Profile.new
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)

    if @profile.save
      flash[:success] = "Profile picture updated!"
      redirect_to root_path
    else
      flash[:danger] = "Something went wrong!"
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to root_path
    else
      render action: :edit
    end
  end


  private

  def profile_params
    params.require(:profile).permit(:avatar)
  end
end