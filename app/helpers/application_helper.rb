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

  def find_user_from_friendship(friendship)
    user_id = friendship.sent_by_id
    user = User.find(user_id)
  end
end
