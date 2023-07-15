require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }

    it 'should validate the comments_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: -1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal 0')
    end

    it 'title should not exceed 250 characters' do
      example_title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus tellus nec orci iaculis rhoncus. ' \
                      'Sed eleifend lectus et ultrices scelerisque. Morbi non lacus quis massa hendrerit luctus eu in dolor. ' \
                      'Sed ut nisi vel diam suscipit tempus. Sed at lectus a sem efficitur interdum. Vestibulum ac semper justo. ' \
                      'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. ' \
                      'Cras pharetra est ut purus malesuada, ac iaculis arcu aliquam. Nulla varius turpis vel metus commodo, ' \
                      'ac iaculis dolor accumsan. Integer venenatis mauris sed nunc euismod iaculis. ' \
                      'Vivamus tincidunt lectus eu aliquet rutrum. Phasellus malesuada purus vitae augue fermentum congue. ' \
                      'Fusce condimentum dui nec tortor aliquam '
      post = Post.new(title: example_title, comments_counter: 1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('cannot exceed 250 characters')
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).with_foreign_key('post_id') }
    it { should have_many(:likes).with_foreign_key('post_id') }
  end

  describe 'update_comments_counter' do
    let(:user) { create(user) }

    it 'should update the comments_counter with the correct count' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')

      post.update_comments_counter

      expect(post.comments_counter).to eq(3)
    end
  end

  def update_recent_comments_counter
    let(:user) { create(user) }

    it 'should return the three most recent posts and no more' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      old_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      comment_one = Comment.create(author_id: user.id, post_id:, text: 'text')
      comment_two = Comment.create(author_id: user.id, post_id:, text: 'text')
      comment_three = Comment.create(author_id: user.id, post_id:, text: 'text')
      comment_four = Comment.create(author_id: user.id, post_id:, text: 'text')
      comment_five = Comment.create(author_id: user.id, post_id:, text: 'text')

      expect(post.most_recent_comments).to include(comment_one)
      expect(post.most_recent_comments).to include(comment_two)
      expect(post.most_recent_comments).to include(comment_three)
      expect(post.most_recent_comments).to include(comment_four)
      expect(post.most_recent_comments).to include(comment_five)
      expect(post.most_recent_comments).to_not include(old_comment)
    end
  end
  
  describe '#increment_posts_counter' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.new(title: 'Example Title', comments_counter: 0, likes_counter: 0, author: user) }
    it 'increments the posts_counter of the author' do
      expect { post.send(:increment_posts_counter) }.to change { user.reload.posts_counter }.by(1)
    end
  end
  
end
