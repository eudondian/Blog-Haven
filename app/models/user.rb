class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validate :posts_counter_greater_than_zero
  validates :photo, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' }

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def posts_counter_greater_than_zero
    return unless posts_counter.present? && posts_counter.negative?

    errors.add(:postsCounter, 'must be greater than or equal 0')
  end

  def increment_posts_counter
    author.increment!(posts_counter:)
  end
end
