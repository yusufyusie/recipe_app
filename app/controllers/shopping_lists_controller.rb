class ShoppingListsController < ApplicationController
  def index
    @user = current_user
    @recipes = Recipe.where(user: @user)
    @missing_numbers = {}
    @ingredients = RecipeFood.where(recipe: @recipes).group_by { |ingredient| ingredient.food.name }

    @total_price = @ingredients.map do |food_name, ingredients|
      total_quantity_required = ingredients.map(&:quantity).compact.sum # Add compact before sum
      user_food = @user.foods.find_by(name: food_name)
      missing_quantity = if user_food
                           [total_quantity_required - user_food.quantity.to_i,
                            0].max
                         else
                           total_quantity_required
                         end
      @missing_numbers[food_name] = missing_quantity
      missing_quantity * ingredients.first.food.price
    end.sum
  end
end
