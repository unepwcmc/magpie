FactoryGirl.define do
  factory :analysis do
    name 'my interesting polygons'
  end
  factory :polygon do
    data [50, 50].to_json
  end
end