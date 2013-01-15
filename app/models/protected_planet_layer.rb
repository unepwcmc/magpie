class ProtectedPlanetLayer < ProjectLayer
  def rasters_select
    get_rasters.map { |r| [r['display_name'], r['id']] }
  end

  def get_rasters
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end

  def operations_select
    [['Protected area KM2', 'area_protected_km2']]
  end
end
