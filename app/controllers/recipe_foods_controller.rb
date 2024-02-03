class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_recipe, only: %i[create]
  before_action :set_recipe_food, only: %i[edit update destroy show]

  def index
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

    if @recipe_food.save
      flash[:success] = 'Ingredient added successfully!'
      redirect_to user_recipe_path(@user, @recipe)
    else
      flash.now[:error] = 'Error: ingredient could not be added!'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to user_recipe_path(@recipe.user, @recipe), notice: 'Ingredient was successfully updated.'
    else
      render :edit
    end
  end

 def destroy
  @recipe_food.destroy!
  flash[:success] = 'Ingredient was deleted successfully!'
  redirect_to user_recipe_path(@recipe.user, @recipe)
end

  private

  def set_user
    @user = current_user
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_food
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
