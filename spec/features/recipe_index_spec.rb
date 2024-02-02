require 'rails_helper'

RSpec.describe 'When I open user index page', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'Yesuf', email: 'yesuf023@example.com', password: 'yessecret')
    @user.confirm
    sleep(1)

    visit new_user_session_path
    fill_in 'Email', with: 'yesuf023@example.com'
    fill_in 'Password', with: 'yessecret'
    click_button 'Log in'
    sleep(1)

    @recipe1 = Recipe.create(user: @user, name: 'Greek Salad', description: 'This is my favourite salad!',
                             preparation_time: 0, cooking_time: 0)
    @recipe2 = Recipe.create(user: @user, name: 'Japanese Salad', description: 'I love this recipe very much! ' * 5,
                             preparation_time: 0, cooking_time: 0)
    visit(user_recipes_path(@user))
  end

  it 'has successful status response' do
    expect(page).to have_http_status :ok
  end

  it 'shows the correct heading' do
    expect(page).to have_content('My Recipes')
  end

  it 'shows the names of all recipes' do
    expect(page).to have_content('Greek Salad')
    expect(page).to have_content('Japanese Salad')
  end

  it 'shows the Remove button 2 times' do
    expect(page).to have_button('Remove', count: 2)
  end

  it 'shows the New Recipe button' do
    expect(page).to have_link('New Recipe', href: new_user_recipe_path(@user))
  end

  context 'When I click on a Recipe name' do
    it "redirects me to that recipe's show page" do
      click_link('Greek Salad')
      expect(page).to have_current_path(user_recipe_path(@user, @recipe1))
    end

    it "redirects me to that recipe's show page" do
      click_link('Japanese Salad')
      expect(page).to have_current_path(user_recipe_path(@user, @recipe2))
    end
  end

  context 'When I click on New Recipe button' do
    it 'redirects me to form that adds Recipe' do
      click_link('New Recipe')
      expect(page).to have_current_path(new_user_recipe_path(@user))
    end
  end

  context 'When I click on Remove button' do
    it 'removes this item' do
      within first('.card') do
        click_button('Remove')
      end
      expect(page).to_not have_content('Greek Salad')
    end
  end
end
