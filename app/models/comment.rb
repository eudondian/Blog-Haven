class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :author, class_name: 'User'
  after_save :increm

  def updateCommentsCounter
    post.increment!(:comments_counter)
  end
end