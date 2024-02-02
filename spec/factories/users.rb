FactoryBot.define do
  factory :user do
    sequence(:name) { |_n| "Test User #{n}" }
    sequence(:email) { |_n| "testuser#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
