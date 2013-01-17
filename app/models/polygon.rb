class Polygon < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :geometry

  belongs_to :area_of_interest

  before_validation do
    self.geometry = self.geometry.to_s
  end

  def to_geo_json
    {
      type: "Feature",
      id: id,
      properties: {},
      geometry: JSON.parse(geometry)
    }
  end

  def to_wkt
    # '{"type":"Polygon", "coordinates":[[[54.13238525390625, 24.77426615577134], [53.86871337890625, 24.392130270038873], [54.4207763671875, 24.399634316776858], [54.13238525390625, 24.77426615577134]]]}'
    # '{"type": "Circle", "coordinates": [24.953689859170165, 54.525146484375], "radius":17612.640973738577}'

    parsed_geometry, points = JSON.parse(geometry), []

    if parsed_geometry['type'] == 'Polygon'
      parsed_geometry['coordinates'][0].each { |point| points << "#{point[0]} #{point[1]}" }

      return { id: id, the_geom: "POLYGON((#{points.join(',')}))" }
    elsif parsed_geometry['type'] == 'Circle'
      response = Net::HTTP.get_response("carbon-tool.cartodb.com", URI.escape("/api/v2/sql?format=json&q=SELECT ST_AsText(ST_Transform(ST_Buffer(ST_Transform((ST_GeomFromText('POINT(#{parsed_geometry['coordinates'][0]} #{parsed_geometry['coordinates'][1]})',4326)),900913),#{parsed_geometry['radius']}),4326))"))

      return { id: id, the_geom: JSON.parse(response.body)['rows'][0]['st_astext'] }
    end
  end
end
