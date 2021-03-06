module ApplicationHelper

  def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def find_friendship_from_friend_request(request)
    friendship = Friendship.where("sent_by_id = ? AND sent_to_id = ?", request.id, current_user.id)
  end

  def find_friendship(user)
    friendship = Friendship.find_by(sent_to_id: user.id, sent_by_id: current_user.id, status: true)
  end

  def request_sent(user)
    return true if current_user.pending_requests.where("sent_to_id = ?", user.id).exists?
  end

  def waiting_for_response(user)
    return true if current_user.recieved_requests.where("sent_by_id = ?", user.id).exists?
  end

  def is_friend?(user_id)
    return true if Friendship.where("sent_by_id = ? AND sent_to_id = ? AND status = ?", current_user.id, user_id, true).present?
  end

  def has_been_liked?(post)
    return false if post.likes.empty?

    post.likes.each do |like|
      if like.user_id == current_user.id
        return true
      end
    end
    return false
  end

  def find_like(post)
    like = Like.find_by(post_id: post.id, user_id: current_user.id)
  end

  def profile_image?(user)
    return true if user.profile.nil? || !user.profile.avatar.attached?
  end
end
