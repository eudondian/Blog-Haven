require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  before :all do
    @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')
    @post1 = Post.create(title: 'I am the champion', text: 'I am the champ of the WWE.', author: @user)
    @post2 = Post.create(title: 'You can\'t see me', text: 'My time is now. It\'s the frenchise.', author: @user)
    @post3 = Post.create(title: 'I will never give up', text: 'I will never give up. I will never surrender.', author: @user)
    @post4 = Post.create(title: 'No one can beat me', text: 'No one can beat me. I am the best.', author: @user)
    @post5 = Post.create(title: 'Like it or not', text: 'Like it or not, I am the best.', author: @user)
  end

  describe 'index page' do
    before :example do
      visit users_path
    end

    it 'should user information' do
      expect(page).to have_content(@user.name)
      expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
      expect(page).to have_content(@user.posts_counter)
    end

    it 'should redirect to user show page' do
      click_on "#{@user.name} ##{@user.id}"
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
