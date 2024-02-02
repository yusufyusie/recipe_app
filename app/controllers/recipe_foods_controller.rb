
class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index new show edit create destroy]
  before_action :set_recipe_food, only: %i[show edit update destroy]

  def index
    @recipe_foods = @user.recipe_foods.includes(:recipe, :food)
  end

  def new
    @recipe_food = @user.recipe_foods.build
  end

  def create
    @recipe_food = @user.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      redirect_to recipe_foods_path, notice: 'Recipe food added successfully.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_foods_path, notice: 'Recipe food updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @recipe_food.destroy
    redirect_to recipe_foods_path, notice: 'Recipe food deleted successfully.'
  end

  private

  def set_user
    @user = current_user
  end

  def set_recipe_food
    @recipe_food = @user.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
