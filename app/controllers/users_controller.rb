class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends

    if current_user.id == @user.id
      @new_post = @user.posts.build
    end
  end
end