object @project
attributes :id, :name
child @layers => :layers do
  attributes :id, :display_name, :tile_url, :is_displayed
end
