class FriendshipsController < ApplicationController

  def create
    
    @friendship = current_user.friend_sent.build(sent_to_id: params[:user_id])

    if @friendship.save

      # Create notifications for sent_to user
      Notification.create(recipient: User.find(params[:user_id]), actor: current_user, action: " wants to be friends", notifiable: @friendship)

      flash[:success] = "New request sent!"
    else
      flash[:failure] = "Friend request failed!"
    end
    redirect_back fallback_location: root_path
  end

  def accept_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship

    @friendship.status = true

    # Delete notification on friend acceptance
    @notification = Notification.find_by(recipient: current_user, actor: params[:user_id])
    @notification.destroy

    if @friendship.save
      flash[:success] = "Friend request accepted!"
      @friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
      @friendship2.save
    else
      flash[:danger] = "Friend request not accepted!"
    end
    redirect_back fallback_location: root_path
  end

  def decline_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship

    # Delete notification on friend decline
    @notification = Notification.find_by(recipient: current_user, actor: params[:user_id])
    @notification.destroy

    @friendship.destroy
    flash[:succss] = "Friend request rejected!"
    redirect_back fallback_location: root_path
  end

  def delete
    @friendship = Friendship.find_by(sent_to_id: params[:user_id], sent_by_id: current_user.id, status: true)
    if @friendship.destroy
      flash[:success] = "Friend destroyed!"
      redirect_back fallback_location: root_path
    end
  end
end