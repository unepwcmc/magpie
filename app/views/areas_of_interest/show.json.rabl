object @area_of_interest
attributes :id, :name
child polygons: :polygons do
  attributes :id, :geometry
end
child results: :results do
  attributes :id, :display_name, :value, :unit, :layer_id
end
