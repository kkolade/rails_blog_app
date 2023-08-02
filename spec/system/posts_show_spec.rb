require_relative '../rails_helper'
require 'capybara/rspec'

RSpec.describe 'Post show page', type: :system do
  let!(:user) { User.create(name: 'Test User') }
  let!(:post) { user.posts.create(title: 'Test Post Title', text: 'Test Post Text') }
  let!(:comment1) { post.comments.create(author: user, text: 'Comment 1') }
  let!(:comment2) { post.comments.create(author: user, text: 'Comment 2') }

  before do
    visit post_path(post)
  end

  it 'displays the post\'s title' do
    expect(page).to have_content(post.title)
  end

  it 'displays the author of the post' do
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

  it 'displays the username of each commentor' do
    expect(page).to have_content(comment1.author.name)
    expect(page).to have_content(comment2.author.name)
  end

  it 'displays the comment each commentor left' do
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end

end
