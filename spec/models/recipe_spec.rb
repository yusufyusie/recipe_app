require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { build(:recipe, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }
    it { should validate_length_of(:description).is_at_most(2000) }
    it { should validate_numericality_of(:preparation_time).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:cooking_time).is_greater_than_or_equal_to(0) }
  end

  describe 'recipe creation' do
    it 'is valid with valid attributes' do
      expect(recipe).to be_valid
    end

    it 'is not valid without a name' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end
  end
end
