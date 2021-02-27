class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_one :profile

  has_many :posts, dependent: :destroy
  has_many :friend_posts, through: :friends, source: :posts

  has_many :comments, dependent: :destroy

  has_many :notifications, foreign_key: 'recipient_id'
  
  has_many :likes, dependent: :destroy

  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'sent_by_id', inverse_of: 'sent_by', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'sent_to_id', inverse_of: 'sent_to', dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) }, through: :friend_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends) }, through: :friend_sent, source: :sent_to
  has_many :recieved_requests, -> { merge(Friendship.not_friends) }, through: :friend_request, source: :sent_by

  # Returns an array of posts from most recent to oldest by the user and user's friends
  def friend_and_user_posts
    user_friends = friends
    all_posts = []
    user_friends.each do |friend|
      friend.posts.each do |post|
        all_posts << post
      end
    end
    posts.each do |post|
      all_posts << post
    end
    ordered_posts = all_posts.sort_by { |post| post[:created_at] }.reverse
  end

  def full_name
    first_name + " " + last_name
  end

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end
  
  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
          user.email = data["email"]
        end
      end
    end
end
