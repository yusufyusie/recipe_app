require 'rails_helper'

RSpec.describe 'Adding a new ingredient to a recipe', type: :feature do
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

    @food1 = Food.create(user: @user, name: 'Apple', measurement_unit: 'kg', price: 10, quantity: 4)
    @food2 = Food.create(user: @user, name: 'Pear', measurement_unit: 'kg', price: 10, quantity: 5)
    @recipe = Recipe.create(user: @user, name: 'Greek Salad', description: 'This is my favourite salad!',
                            preparation_time: 0, cooking_time: 0)
    visit(new_user_recipe_recipe_food_path(@user, @recipe))
  end

  it 'displays the correct heading' do
    expect(page).to have_content('Add New Ingredient')
  end

  it 'displays a quantity field with a default value of 1' do
    expect(page).to have_selector("input#recipe_food_quantity[value='1']")
  end

  it 'displays a dropdown with the names of the user\'s foods' do
    expect(page).to have_select('Food', options: ['Select a food', 'Apple', 'Pear'])
  end

  it 'displays a link to add a new food' do
    expect(page).to have_link('Add New Food', href: new_food_path)
  end

  it 'displays a button to add the ingredient' do
    expect(page).to have_button('Add Ingredient')
  end

  context 'when the Add Ingredient button is clicked' do
    it 'redirects to the recipe foods list' do
      click_button('Add Ingredient')
      expect(page).to have_current_path(user_recipe_recipe_foods_path(@user, @recipe))
    end
  end

  context 'when the Add New Food link is clicked' do
    it 'redirects to the new food form' do
      click_link('Add New Food')
      expect(page).to have_current_path(new_food_path)
    end
  end

  context 'when the Back to Recipe Foods List link is clicked' do
    it 'redirects to the recipe foods list' do
      click_link('Back to Recipe Foods List')
      expect(page).to have_current_path(user_recipe_recipe_foods_path(@user, @recipe))
    end
  end
end
