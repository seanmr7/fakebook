class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id
      @post = @user.posts.build
    end
  end
end