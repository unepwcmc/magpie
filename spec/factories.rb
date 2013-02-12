FactoryGirl.define do
  factory :admin do
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :area_of_interest do
    name 'Area of Interest'
    workspace
  end

  factory :calculation do
    display_name 'My Calculation'
  end

  factory :polygon do
    area_of_interest
  end

  factory :polygon_upload do
    state 'Not yet uploaded'
    area_of_interest
  end

  factory :project do
    sequence(:name) { |n| "carbon_#{('a'..'z').to_a[n]}" }
  end

  factory :workspace
end
