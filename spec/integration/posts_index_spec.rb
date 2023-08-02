require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User post index page', type: :system do
  let!(:user) { User.create(name: 'Test User') }
  let!(:post1) { user.posts.create(title: 'Post 1 Title', text: 'Post 1 Text') }
  let!(:post2) { user.posts.create(title: 'Post 2 Title', text: 'Post 2 Text') }
  # ... create more posts as needed

  before do
    visit user_posts_path(user)
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

  it 'displays a post\'s title and body' do
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.text.truncate_words(80))
  end

  it 'displays the first comments on a post' do
    expect(page).to have_content(post1.last_five_comments)
  end

  it 'displays the number of comments a post has' do
    expect(page).to have_content("Comments: #{post1.comments.count}")
  end

  it 'displays the number of likes a post has' do
    expect(page).to have_content("Likes: #{post1.likes.count}")
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    # Create more posts to exceed the number that fits on the view
    expect(page).to have_css('.pagination')
  end

  it 'redirects to post show page when clicking on a post' do
    click_link post1.title
    expect(current_path).to eq(post_path(post1))
  end
end