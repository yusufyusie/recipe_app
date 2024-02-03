class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @public_recipes = Recipe.where(public: true) || []
    @user_recipes = user_signed_in? ? (current_user.recipes || []) : []
  end
end
