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
  node(:value) do |result|
    if result.value
      begin
        Yajl::Parser.parse(result.value)
      rescue
        result.value
      end
    end
  end

  glue :statistic do
    attributes :display_name, :unit, :project_layer_id
  end
end
