object @area_of_interest
attributes :id, :name
child polygons: :polygons do
  attributes :id
  node :geometry do |polygon|
    JSON.parse(polygon.geometry)
  end
end
child results: :results do
  attributes :id, :value
  node(:value_json) { |result| result.value_json && Yajl::Parser.parse(result.value_json) }

  glue :calculation do
    attributes :display_name, :unit, :project_layer_id
  end
end
