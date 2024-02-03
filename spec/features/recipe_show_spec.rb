require 'rails_helper'

RSpec.describe 'When I open recipe show page', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create!(name: 'Yesuf', email: 'yesuf023@example.com', password: 'yessecret')
    @user.confirm
    sleep(1)

    visit new_user_session_path
    fill_in 'Email', with: 'yesuf023@example.com'
    fill_in 'Password', with: 'yessecret'
    click_button 'Log in'
    sleep(1)

    @recipe = Recipe.create!(user: @user, name: 'Greek Salad', description: 'This is my favourite salad!',
                             preparation_time: 2, cooking_time: 1)
    visit(user_recipe_path(@user, @recipe))
  end

  it 'has successful status response' do
    expect(page).to have_http_status :ok
  end

  it 'shows the name of the recipe' do
    expect(page).to have_content('Greek Salad')
  end

  it 'shows the cooking time of the recipe' do
    expect(page).to have_content('Cooking time: 1 minutes')
  end

  it 'shows the preparation time of the recipe' do
    expect(page).to have_content('Preparation time: 2 minutes')
  end

  it 'shows the full description of the recipes' do
    expect(page).to have_content('This is my favourite salad!')
  end

  context 'shows correct links' do
    it 'to Back to recipes' do
      expect(page).to have_link('Back to recipes', href: user_recipes_path(@user))
    end

    it 'to Generate Shopping List' do
      expect(page).to have_link('Generate Shopping List', href: shopping_lists_path)
    end

    it 'to Add New Ingredient' do
      expect(page).to have_link('Add New Ingredient', href: new_user_recipe_recipe_food_path(@user, @recipe.id))
    end
  end

  context 'When I click on Add New Ingredient' do
    it 'redirects me to the form that adds new recipe_foods' do
      click_link('Add New Ingredient')
      expect(page).to have_current_path(new_user_recipe_recipe_food_path(@user, @recipe.id))
    end
  end

  context 'When I click on Generate Shopping List' do
    it 'redirects me to the shopping list path' do
      click_link('Generate Shopping List')
      expect(page).to have_current_path(shopping_lists_path)
    end
  end

  context 'When I click on Back to recipes' do
    it 'redirects me to the user recipes path' do
      click_link('Back to recipes')
      expect(page).to have_current_path(user_recipes_path(@user))
    end
  end

  context 'When I click on the public checkbox' do
    it 'toggles the checkbox' do
      find('.form-check-input').click
      expect(find('.form-check-input')).to be_checked
      find('.form-check-input').click
      expect(find('.form-check-input')).not_to be_checked
    end
  end
end
