class UsersController < ApplicationController

  def index
    @users = users.all
  end

  def show
    @user = User.find(params[:id])
  end
end