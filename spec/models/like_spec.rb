require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:Post) }

  describe 'methods' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }

    it 'should validate the likes_counter is greater than or equal to 0' do
      post = Post.new(title: 'title', comments_counter: -1, likes_counter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal 0')
    end
  end
end
