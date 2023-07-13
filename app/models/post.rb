class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'
  after_save :increment_posts_counter

  def posts_counter
    author.increment!(:posts_counter)
  end

  def most_recent_comments
      comments_order(created_at: :desc).limit(5)
  end
end
