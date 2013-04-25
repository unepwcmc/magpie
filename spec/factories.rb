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

  factory :result do
    area_of_interest
    statistic
  end

  factory :statistic do
    display_name 'My Statistic'
    association :project_layer, factory: :protected_planet_layer
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

  factory :protected_planet_layer do
    display_name "Das Protected Planet Layer"
  end

  factory :workspace
end
