require_relative '../rails_helper'
require 'capybara/rspec'

RSpec.describe 'User show page', type: :system do
  let!(:user) { User.create(name: 'Test User', bio: 'Test bio', posts_counter: 3) }
  let!(:post1) { user.posts.create(title: 'Post 1 Title', text: 'Post 1 Text') }
  let!(:post2) { user.posts.create(title: 'Post 2 Title', text: 'Post 2 Text') }
  let!(:post3) { user.posts.create(title: 'Post 3 Title', text: 'Post 3 Text') }

  before do
    visit user_path(user)
  end

  it 'displays user profile picture' do
    expect(page).to have_css('.user-photo')
  end

  it 'displays user username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  it 'displays user bio' do
    expect(page).to have_content(user.bio)
  end

  it 'displays the user\'s first 3 posts' do
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post3.title)
  end

  it 'redirects to post show page when clicking a user\'s post' do
    click_link post1.title
    expect(current_path).to eq(post_path(post1))
  end

  it 'redirects to user\'s posts index page when clicking to see all posts' do
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end
