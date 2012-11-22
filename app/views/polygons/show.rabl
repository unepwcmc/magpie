object @polygon => ''
attributes :id, :area_of_interest_id
node :geometry do |p|
  JSON.parse(p.geometry)
end
