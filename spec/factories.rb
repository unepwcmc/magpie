FactoryGirl.define do
  factory :tenant do
    name 'CarbonCalculator'
  end
  factory :layer do
    name 'carbon'
  end
  factory :tenant_layer do
    layer
  end
  factory :analysis do
    name 'my interesting polygons'
  end
  factory :area do
    name 'AOI#1'
    is_summary false
  end
  factory :polygon do
    geometry [50, 50].to_json
  end
  factory :operation do
    name "Avg"
    display_name "Average of Carbon"
  end
  factory :calculation do
    layer
    operation
  end
  factory :calculated_stat do
    area
    calculation
  end
end
