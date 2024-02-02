# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    # Add any other attributes you have on your User model
  end
end
