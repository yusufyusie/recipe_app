# app/controllers/foods_controller.rb:

class FoodsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_food, only: [:show, :edit, :update, :destroy]
  
    def index
      @foods = @user.foods.includes(recipe_foods: :recipe) # fixed N+1
    #   @recipes_with_foods = @user.recipes.includes(recipe_foods: :foods)
    end
  
    def new
      @food = @user.foods.build
    end
  
    def create
      @food = @user.foods.build(food_params)
      if @food.save
        redirect_to foods_path, notice: 'Food added successfully.'
      else
        render :new
      end
    end
  
    def shopping_list
      # Show the list of missing food for all recipes of the logged-in user
      @missing_foods = calculate_missing_foods
    end
  
    private
  
    def set_user
      @user = current_user
    end
  
    def set_food
      @food = @user.foods.find(params[:id])
    end
  
    def food_params
      params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
    end
  
    def calculate_missing_foods
        # Get all foods for the user
        user_foods = @user.foods.pluck(:name)
      
        # Get all foods needed for recipes
        recipe_foods = RecipeFood.includes(:food, :recipe).where(recipes: { user_id: @user.id })
      
        # Extract food names from recipe_foods
        recipe_food_names = recipe_foods.map { |rf| rf.food.name }
      
        # Calculate missing foods
        missing_foods = recipe_food_names - user_foods
      
        # Count the total items and total price of the missing food
        total_items = missing_foods.size
        total_price = recipe_foods.where(foods: { name: missing_foods }).sum(:quantity)
      
        { missing_foods: missing_foods, total_items: total_items, total_price: total_price }
      end
      
  end
  