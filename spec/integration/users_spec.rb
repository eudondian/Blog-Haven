require "rails_helper"

RSpec.describe "Users", type: :system, js: true do
  before :all do
    @user = User.create(name: "John Doe", photo: "https://picsum.photos/200/300", bio: "I am John Doe")
  end

  describe "index page" do
    before :example do
      visit users_path
    end

    it "should user information" do
      expect(page).to have_content(@user.name)
      expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
      expect(page).to have_content(@user.posts_counter)
    end

    it "should redirect to user show page" do
      click_on "#{@user.name} ##{@user.id}"
      expect(page).to have_current_path(user_path(@user))
    end
  end

  describe "show page" do
    before :example do
      visit user_path(@user)
    end
    
    # I can see the user's profile picture.
    # I can see the user's username.
    # I can see the number of posts the user has written.
    # I can see the user's bio.
    # I can see the user's first 3 posts.
    # I can see a button that lets me view all of a user's posts.
    # When I click a user's post, it redirects me to that post's show page.
    # When I click to see all posts, it redirects me to the user's post's index page.
    #   end
end