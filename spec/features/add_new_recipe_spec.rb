require 'rails_helper'

RSpec.describe 'Creating a new recipe', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    @user.confirm
    sleep(1)

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'topsecret'
    click_button 'Log in'
    sleep(1)

    visit new_user_recipe_path(@user)
  end

  it 'renders the new recipe form' do
    expect(page).to have_content('New Recipe')
    expect(page).to have_field('Name')
    expect(page).to have_field('Preparation time')
    expect(page).to have_field('Cooking time')
    expect(page).to have_field('Description')
    expect(page).to have_field('Public')
    expect(page).to have_button('Create Recipe')
  end

  context 'when the form is submitted' do
    it 'creates a new recipe and redirects to the recipe show page' do
      fill_in 'Name', with: 'Greek Salad'
      fill_in 'Preparation time', with: 10
      fill_in 'Cooking time', with: 20
      fill_in 'Description', with: 'This is a delicious salad!'
      check 'Public'
      click_button 'Create Recipe'

      expect(page).to have_current_path(user_recipe_path(@user, Recipe.last))
      expect(page).to have_content('Greek Salad')
      expect(page).to have_content('Preparation time: 10 minutes')
      expect(page).to have_content('Cooking time: 20 minutes')
      expect(page).to have_content('This is a delicious salad!')
    end
  end

  context 'when the Back to recipes link is clicked' do
    it 'redirects to the user recipes index page' do
      click_link 'Back to recipes'
      expect(page).to have_current_path(user_recipes_path(@user))
    end
  end
end
