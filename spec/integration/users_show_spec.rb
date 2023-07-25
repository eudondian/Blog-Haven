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

  describe 'show page' do
    before :example do
      visit user_path(@user)
    end

   # I can see the user's profile picture.
    it "displays the user's information" do
      expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.posts_counter)
      expect(page).to have_content(@user.bio)

      @user.most_recent_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end

      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end


    # When I click a user's post, it redirects me to that post's show page.
    it "redirects to the post show page when clicking a user's post" do
      click_on @post5.title
      expect(page).to have_current_path(user_post_path(@user, @post5))
    end

    # When I click to see all posts, it redirects me to the user's post's index page.
    it "redirects to the user's post index page when clicking to see all posts" do
      click_on 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end