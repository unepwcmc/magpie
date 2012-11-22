object @aoi => ''
attributes :id, :name

child :polygons do
  attributes :id, :geometry => partial('polygons/geometry', :object => @geometry)
end

child :results do
  attributes :value
  glue :calculation do
    attributes :unit, :display_name, :app_layer_id
  end
end
