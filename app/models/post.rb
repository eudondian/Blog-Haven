class Post < ApplicationRecord
  validates :title, presence: true
  validate :title_not_exceed_250_chars
  validate :comments_counter_greater_than_zero
  validate :likes_counter_greater_than_zero

  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: 'post_id', dependent: :destroy
  has_many :comments, foreign_key: 'post_id', dependent: :destroy

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def title_not_exceed_250_chars
    return unless title.present? && title.length > 250

    errors.add(:title, 'cannot exceed 250 characters')
  end

  def comments_counter_greater_than_zero
    return unless comments_counter.present? && comments_counter.negative?

    errors.add(:comments_counter, 'must be greater than or equal 0')
  end

  def likes_counter_greater_than_zero
    return unless likes_counter.present? && likes_counter.negative?

    errors.add(:likes_counter, 'must be greater than or equal 0')
  end

  after_save :increment_posts_counter

  # Private
  def increment_posts_counter
    author.increment!(:posts_counter)
  end
end
