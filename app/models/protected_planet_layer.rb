class ProtectedPlanetLayer < ProjectLayer
  def self.get_providers
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end
end
