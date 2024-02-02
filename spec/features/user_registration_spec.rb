require 'rails_helper'

RSpec.feature 'UserRegistrations', type: :feature do
  scenario 'user signs up with valid data' do
    visit new_user_registration_path

    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end

  scenario 'user signs up with invalid data' do
    visit new_user_registration_path

    fill_in 'Name', with: ''
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content("Name can't be blank")
  end
end
