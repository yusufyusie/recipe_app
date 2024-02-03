# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# Create users
user1 = User.find_or_create_by!(name: 'User 1', email: 'user1@example.com') do |user|
  user.password = 'password1'
end

user2 = User.find_or_create_by!(name: 'User 2', email: 'user2@example.com') do |user|
  user.password = 'password2'
end

user3 = User.find_or_create_by!(name: 'User 3', email: 'user3@example.com') do |user|
  user.password = 'password3'
end

User.find_or_create_by!(name: 'Yesuf Fenta', email: 'yesuf023@gmail.com') do |user|
  user.password = '123456'
end

# Create recipes for each user
recipe1 = Recipe.find_or_create_by!(name: 'Spaghetti Bolognese', user: user1) do |recipe|
  recipe.description = 'A classic Italian dish with a meaty, tomato sauce.'
  recipe.preparation_time = 30
  recipe.cooking_time = 120
end

recipe2 = Recipe.find_or_create_by!(name: 'Chicken Curry', user: user2) do |recipe|
  recipe.description = 'A spicy, flavorful dish with chicken, vegetables, and a rich curry sauce.'
  recipe.preparation_time = 20
  recipe.cooking_time = 60
end

recipe3 = Recipe.find_or_create_by!(name: 'Vegetable Stir Fry', user: user3) do |recipe|
  recipe.description = 'A quick, easy, and healthy dish with a variety of fresh vegetables.'
  recipe.preparation_time = 15
  recipe.cooking_time = 15
end

# Create food items for each user
food1 = Food.find_or_create_by!(name: 'Tomato', user: user1) do |food|
  food.quantity = 10
  food.price = 5.0
end

food2 = Food.find_or_create_by!(name: 'Chicken', user: user2) do |food|
  food.quantity = 5
  food.price = 10.0
end

food3 = Food.find_or_create_by!(name: 'Broccoli', user: user3) do |food|
  food.quantity = 15
  food.price = 7.5
end

# Associate food items with recipes
RecipeFood.find_or_create_by!(recipe: recipe1, food: food1)
RecipeFood.find_or_create_by!(recipe: recipe2, food: food2)
RecipeFood.find_or_create_by!(recipe: recipe3, food: food3)
