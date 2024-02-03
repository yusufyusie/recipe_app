require 'rails_helper'

RSpec.feature 'User Food List', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'Yesuf', email: 'yesuf023@example.com', password: 'yessecret')
    @user.confirm
    log_in_user('yesuf023@example.com', 'yessecret')
  end

  scenario 'User views their Food List page' do
    Food.create(name: 'Apple', measurement_unit: 'kg', price: '10.99', quantity: 5, user: @user)
    visit user_foods_path(@user)
    expect(page).to have_link('New Food', href: new_user_food_path(@user))
    expect(page).to have_selector('tbody tr td', text: 'Apple')
    expect(page).to have_selector('tbody tr td', text: 'kg')
    expect(page).to have_selector('tbody tr td', text: '$2.20')
    expect(page).to have_link('Delete', href: user_food_path(@user, Food.first))
  end

  private

  def log_in_user(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
    sleep(1)
  end
end
