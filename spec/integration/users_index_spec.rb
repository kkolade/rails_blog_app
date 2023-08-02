require_relative '../rails_helper'
require 'capybara/rspec'

RSpec.describe 'Users index page', type: :feature do
  before do
    @user1 = User.create(name: 'User 1', posts_counter: 3)
    @user2 = User.create(name: 'User 2', posts_counter: 5)
    @user3 = User.create(name: 'User 3', posts_counter: 2)
  end

  describe 'when visiting the index page' do
    before { visit users_path }

    it 'displays the username of all other users' do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user3.name)
    end

    it 'displays the profile picture for each user' do
      expect(page).to have_css('.user-photo')
    end

    it 'displays the number of posts for each user' do
      expect(page).to have_css('.user-post-count', text: /Number of posts: \d+/i, count: 3)
    end

    it 'redirects to user show page when clicking on a user' do
      click_link @user1.name
      expect(current_path).to eq(user_path(@user1))
    end
  end
end
