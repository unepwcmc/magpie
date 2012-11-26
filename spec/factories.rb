FactoryGirl.define do
  factory :app do
    name 'CarbonCalculator'
  end

  factory :app_layer do
    display_name "Carbon Layer"
    provider_id 1
    tile_url "http://"
    is_displayed true
    type ""
  end

  factory :workspace

  factory :area_of_interest do
    name 'AOI#1'
    is_summary false
    workspace
  end

  factory :polygon do
    geometry "[[[-55.1991338309051,14.166474645080788],[-139.868730478081,21.093987098031544],[-166.29590761341169,80.61927928634917],[-19.022124354384474,82.67187556870495],[-55.1991338309051,14.166474645080788]]]"
    area_of_interest
  end

  factory :operation do
    name "sum"
  end

  factory :calculation do
    display_name "Average of Carbon"
    unit 'Kg'
    app_layer
    operation
  end

  factory :result do
    area_of_interest
    calculation
  end
end
