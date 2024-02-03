require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.create(name: 'Tom', email: 'tommy@example.com', password: 'topsecret')
    @food = Food.new(
      name: 'Apple',
      measurement_unit: 'kg',
      price: 10.99,
      quantity: 5,
      user: @user
    )
  end

  it 'is valid with valid attributes' do
    expect(@food).to be_valid
  end

  it 'is not valid without a name' do
    @food.name = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a measurement unit' do
    @food.measurement_unit = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a price' do
    @food.price = nil
    expect(@food).not_to be_valid
  end

  it 'is not valid without a user' do
    @food.user = nil
    expect(@food).not_to be_valid
  end

  describe '#calculate_unit_price' do
    it 'returns the unit price when quantity is not zero' do
      expect(@food.calculate_unit_price).to eq(10.99 / 5)
    end

    it 'returns zero when quantity is zero' do
      @food.quantity = 0
      expect(@food.calculate_unit_price).to eq(0)
    end
  end
end
