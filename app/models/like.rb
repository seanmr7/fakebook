class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  before_save :check_if_liked

  private

  def check_if_liked
    post = Post.find(self.post_id)
    post.likes.each do |like|
      throw(:abort) if like.user_id == self.user_id 
    end
  end
end
