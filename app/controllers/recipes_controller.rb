class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @public_recipes = Recipe.where(public: true)
    @user_recipes = current_user.recipes
    @recipes = @user_recipes + @public_recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path(current_user), notice: 'Recipe was successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :public, :preparation_time, :cooking_time)
  end
end
