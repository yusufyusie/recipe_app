class PagesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
end
