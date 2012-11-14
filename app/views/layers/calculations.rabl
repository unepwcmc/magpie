collection @layers_with_calculations, :root => "layer_calculations", :object_root => false
attributes :layer_id

child :calculations, :object_root => false do
  attributes :id, :display_name
end
