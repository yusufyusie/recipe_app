require 'rails_helper'

RSpec.describe 'When I open the edit ingredient page', type: :feature do
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
    @recipe_food1 = RecipeFood.create(recipe: @recipe, food: @food1, quantity: 3)
    visit(edit_user_recipe_recipe_food_path(@user, @recipe, @recipe_food1))
  end

  it 'displays the correct heading' do
    expect(page).to have_content('Edit Ingredient')
  end

  it 'displays a quantity field with the current quantity as the default value' do
    expect(page).to have_selector("input#recipe_food_quantity[value='3']")
  end

  it 'displays a dropdown with the names of the user\'s foods' do
    expect(page).to have_select('Food', options: ['Apple', 'Pear'])
  end

  it 'displays an Update button' do
    expect(page).to have_button('Update')
  end

  context 'when the Update button is clicked' do
    it 'redirects to the recipe page' do
      fill_in 'Quantity', with: '5'
      click_button('Update')
      expect(page).to have_current_path(user_recipe_path(@user, @recipe))
    end

    it 'displays the updated quantity on the recipe page' do
      fill_in 'Quantity', with: '5'
      click_button('Update')
      expect(page).to have_content('5')
    end

    it 'displays the updated food name on the recipe page if the food is changed' do
      select 'Pear', from: 'Food'
      click_button('Update')
      expect(page).to have_content('Pear')
    end
  end
end
