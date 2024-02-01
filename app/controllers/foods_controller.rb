# app/controllers/foods_controller.rb:

class FoodsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    # before_action :set_food, only: [:new, :show, :create, :destroy]
  
    def index
    @foods = @user.foods.includes(recipe_foods: :recipe) # fixed N+
    #   @recipes_with_foods = @user.recipes.includes(recipe_foods: :foods)
    end

  #   def show
  #  @foods = @user.foods
  #   end
  
    def new
      # @food = @user.foods.find_by(params[:id])
      @food = @user.foods.build
    end
  
    def create
      @food = @user.foods.build(food_params)
      if @food.save
        redirect_to user_foods_path(@user), notice: 'Food added successfully.'
      else
        render :new
      end
    end

    def destroy
      @food.destroy
      redirect_to user_foods_path(@user), notice: 'Food deleted successfully.'
    end
  
    def shopping_list
      # Show the list of missing food for all recipes of the logged-in user
      @missing_foods = calculate_missing_foods
    end
  
    private
  
    def set_user
      @user = current_user
    end
  
    def food_params
      params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
    end
  
    def calculate_missing_foods
        # Get all foods for the user
        user_foods = @user.foods.pluck(:id)
      
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
  