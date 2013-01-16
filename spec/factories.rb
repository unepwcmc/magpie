FactoryGirl.define do
  factory :admin do
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :project do
    sequence(:name) { |n| "carbon_#{('a'..'z').to_a[n]}" }
  end
end
