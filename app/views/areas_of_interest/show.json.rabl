object @area_of_interest
attributes :id, :name
child polygons: :polygons do
  attributes :id, :geometry
end
child results: :results do
  attributes :id, :value

  glue :calculation do
    attributes :display_name, :unit, :project_layer_id
  end
end
