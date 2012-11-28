object @polygon
attributes :id, :area_of_interest_id
node :geometry do |polygon|
  JSON.parse(polygon.geometry)
end
