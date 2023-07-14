require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }


    it 'should validate the comments_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: -1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal 0')
    end

    it 'should validate the likes_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: -1, likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal 0')
    end

    it 'title should not exceed 250 characters' do
      mock_title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus tellus nec orci iaculis rhoncus. ' \
                   'Sed eleifend lectus et ultrices scelerisque. Morbi non lacus quis massa hendrerit luctus eu in dolor. ' \
                   'Sed ut nisi vel diam suscipit tempus. Sed at lectus a sem efficitur interdum. Vestibulum ac semper justo. ' \
                   'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. ' \
                   'Cras pharetra est ut purus malesuada, ac iaculis arcu aliquam. Nulla varius turpis vel metus commodo, ' \
                   'ac iaculis dolor accumsan. Integer venenatis mauris sed nunc euismod iaculis. ' \
                   'Vivamus tincidunt lectus eu aliquet rutrum. Phasellus malesuada purus vitae augue fermentum congue. ' \
                   'Fusce condimentum dui nec tortor aliquam '
      post = Post.new(title: mock_title, comments_counter: 1, likes_counter: 1)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('cannot exceed 250 characters')
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).with_foreign_key('post_id') }
    it { should have_many(:likes).with_foreign_key('post_id') }
  end

  def most_recent_comments
    let(:user) { create(user) }

    it 'should return the three most recent posts and no more' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      old_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      first_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      second_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      third_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      fourth_comment = Comment.create(author_id: user.id, post_id:, text: 'text')
      fifth_comment = Comment.create(author_id: user.id, post_id:, text: 'text')

      expect(post.most_recent_comments).to include(first_comment)
      expect(post.most_recent_comments).to include(second_comment)
      expect(post.most_recent_comments).to include(third_comment)
      expect(post.most_recent_comments).to include(fourth_comment)
      expect(post.most_recent_comments).to include(fifth_comment)
      expect(post.most_recent_comments).to_not include(old_comment)
    end
  end
end
