FactoryGirl.define do
  factory :app do
    name 'CarbonCalculator'
  end
  factory :app_layer do
    layer
  end
  factory :workspace do
    name 'my interesting polygons'
  end
  factory :area_of_interest do
    name 'AOI#1'
    is_summary false
    workspace
  end
  factory :polygon do
    geometry [50, 50].to_json
    area_of_interest
  end
  factory :operation do
    name "Avg"
  end
  factory :calculation do
    display_name "Average of Carbon"
    layer
    operation
  end
  factory :calculation_result do
    area_of_interest
    calculation
  end
end
