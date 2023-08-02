require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post show page', type: :system do
  let!(:user) { User.create(name: 'Test User') }
  let!(:post) { user.posts.create(title: 'Post Title', text: 'Post Text') }

  before do
    visit user_post_path(user, post)
  end

  it 'displays the post title' do
    expect(page).to have_content(post.title)
  end

  it 'displays the post author' do
    expect(page).to have_content(post.author.name)
  end

  it 'displays the number of comments the post has' do
    expect(page).to have_content("Number of comments: #{post.comments.count}")
  end

  it 'displays the number of likes the post has' do
    expect(page).to have_content("Number of likes: #{post.likes.count}")
  end

  it 'displays the post body' do
    expect(page).to have_content(post.text)
  end

  it 'displays the username of each commenter' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'displays the comment each commenter left' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'can like the post' do
    expect(page).to have_button('Like')
    click_button 'Like'
    expect(page).to have_content("Number of likes: #{post.likes.count + 1}")
  end

  it 'can submit a new comment' do
    expect(page).to have_field('Comment', type: 'textarea')
    fill_in 'Comment', with: 'This is a new comment'
    click_button 'Add Comment'
    expect(page).to have_content('This is a new comment')
  end
end
