class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:success] = "New friend!"
      redirect_to root_path
    else
      flash[:failure] = "Friendship rejected!"
      redirect_to root_path
    end
  end

  def delete
    @friendship = current_user.friendships.find(params[:id])
    if @friendship.destroy
      flash[:success] = "Friend destroyed!"
    end
  end
end