object @workspace => ''
attributes :id

child :areas_of_interest do
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
end
