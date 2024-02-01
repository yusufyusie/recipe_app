class Food < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  def calculate_unit_price
    # Ensure quantity is not zero to avoid division by zero
    return 0 if quantity.zero?

    price / quantity
  end
end
