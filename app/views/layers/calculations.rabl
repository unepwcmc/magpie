collection @layers_with_calculations, :root => "layer_calculations"
attributes :layer_id

child :calculations do
  attributes :id, :display_name
end
