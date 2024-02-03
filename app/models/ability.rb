class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      # Recipe abilities
      can :read, Recipe, public: true
      can :read, Recipe, user_id: user.id
      can :create, Recipe
      can :destroy, Recipe, user_id: user.id

      # Food abilites
      can :read, Food, public: true
      can :read, Food, user_id: user.id
      can :create, Food
      can :destroy, Food, user_id: user.id

      # Recipe abilities
      can :read, Recipe_Food, public: true
      can :read, Recipe_Food, user_id: user.id
      can :create, Recipe_Food
      can :destroy, Recipe_Food, user_id: user.id
    end
  end
end
