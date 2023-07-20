require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'returns a successful response for users index' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('list of all users')
    end

    it 'returns a successful response for users show' do
      @user = User.create(name: 'John Doe', photo: '', bio: 'A user from nowhere')
      get user_path(@user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('Here are the details for the user')
    end
  end
end
