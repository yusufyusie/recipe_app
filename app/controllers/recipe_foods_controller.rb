class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_recipe, only: [:create]
  before_action :set_recipe_food, only: [:edit, :update, :destroy, :show]

  def index
    @recipe_foods = @user.recipe_foods.includes(:recipe, :food)
  end

  def new
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      flash[:success] = 'Ingredient added successfully!'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Error: ingredient could not be added!'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Ingredient updated successfully!'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash.now[:error] = 'Error: ingredient could not be updated!'
      render :edit
    end
  end

  def destroy
    @recipe_food.destroy!
    flash[:success] = 'Ingredient was deleted successfully!'
    redirect_to recipe_path(@recipe_food.recipe_id)
  end

  private

  def set_user
    @user = current_user
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_food
    @recipe_food = @user.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
