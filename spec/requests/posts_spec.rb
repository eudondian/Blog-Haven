require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
   
       it 'returns a successful response for post index' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('list of all posts')
    end

    it 'returns a successful response for post index' do
      @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
      get user_post_path(@user, @post)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('list of all posts')
    end
  end
end
