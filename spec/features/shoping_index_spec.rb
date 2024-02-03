require 'rails_helper'

RSpec.describe 'shopping_lists/index', type: :view do
  before(:each) do
    assign(:ingredients,
           { 'Apple' => [double('Ingredient',
                                food: double('Food', name: 'Apple', price: 2.5),
                                quantity: 2)] })
    assign(:missing_numbers, { 'Apple' => 2 })
    assign(:total_price, 5.0)

    render
  end

  it 'renders the shopping list heading' do
    expect(rendered).to have_selector('h1', text: 'Your Shopping Lists')
  end

  it 'renders the amount of food items to buy' do
    expect(rendered).to have_content('Amount of Food items to buy: 1')
  end

  it 'renders the total value of food needed' do
    expect(rendered).to have_content('Total value of Food needed: $5.00')
  end

  it 'renders the table headers' do
    expect(rendered).to have_selector('thead th', text: 'Food Name')
    expect(rendered).to have_selector('thead th', text: 'Total Quantity Required')
    expect(rendered).to have_selector('thead th', text: 'Missing Quantity')
    expect(rendered).to have_selector('thead th', text: 'Price per Unit')
    expect(rendered).to have_selector('thead th', text: 'Total Price')
  end

  it 'renders the food name in the table' do
    expect(rendered).to have_selector('tbody td', text: 'Apple')
  end

  it 'renders the total quantity required in the table' do
    expect(rendered).to have_selector('tbody td', text: '2')
  end

  it 'renders the missing quantity in the table' do
    expect(rendered).to have_selector('tbody td', text: '2')
  end

  it 'renders the price per unit in the table' do
    expect(rendered).to have_selector('tbody td', text: '2.5')
  end

  it 'renders the total price in the table' do
    expect(rendered).to have_selector('tbody td', text: '5.0')
  end

  it 'renders the total price of all missing ingredients' do
    expect(rendered).to have_content('Total price of all missing ingredients: 5.0')
  end

  it 'renders the back to ingredients link' do
    expect(rendered).to have_link('Back to ingredients')
  end
end
