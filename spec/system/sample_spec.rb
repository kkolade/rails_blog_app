require_relative '../rails_helper'

RSpec.describe 'Sample', type: :system do
  it 'visits the home page' do
    visit root_path
    expect(page).to have_content('Welcome to My Rails App')
  end
end