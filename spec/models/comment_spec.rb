require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'increment_comments_counter' do
    it 'updates the comments_counter with the correct count' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      Comment.create(author_id: user.id, post_id: post.id, text: 'text')

      post.update_comments_counter

      expect(post.comments_counter).to eq(3)
    end
  end

  describe '#most_recent_comments' do
    let(:user) { create(:user) }

    it 'returns the three most recent comments and no more' do
      user = User.create(name: 'name')
      post = Post.create(title: 'title', text: 'text', author_id: user.id)
      old_comment = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      comment_one = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      comment_two = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      comment_three = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      comment_four = Comment.create(author_id: user.id, post_id: post.id, text: 'text')
      comment_five = Comment.create(author_id: user.id, post_id: post.id, text: 'text')

      expect(post.most_recent_comments).to include(comment_one)
      expect(post.most_recent_comments).to include(comment_two)
      expect(post.most_recent_comments).to include(comment_three)
      expect(post.most_recent_comments).to include(comment_four)
      expect(post.most_recent_comments).to include(comment_five)
      expect(post.most_recent_comments).not_to include(old_comment)
    end
  end
end
