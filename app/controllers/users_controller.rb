class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends
    @posts = @user.friend_and_user_posts
    if current_user.id == @user.id
      @new_post = @user.posts.build
    end
  end
end