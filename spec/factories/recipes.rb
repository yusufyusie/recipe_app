FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Test Recipe #{n}" }
    description { "This is a test recipe" }
    preparation_time { 30 }
    cooking_time { 45 }
    user
  end
end
