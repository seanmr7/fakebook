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
end
