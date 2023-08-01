require_relative '../rails_helper'

RSpec.describe 'Sample', type: :system do
  it 'visits the home page' do
    visit root_path
    expect(page).to have_content('ACTIVE USERS')
  end
end