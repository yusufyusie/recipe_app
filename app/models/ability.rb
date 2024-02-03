# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can [:create, :new, :destroy], [User, Recipe, Food, RecipeFood]
    end
  end
end
