object @aoi => ''
attributes :id, :name

child :polygons do
  attributes :id
  node :geometry do |p|
    JSON.parse(p.geometry)
  end
end

child :results do
  attributes :value
  glue :calculation do
    attributes :unit, :display_name, :app_layer_id
  end
end
