module ProjectLayerHelper
  def format_raster_list_for_select raster_list
    get_rasters.map { |r| [r['display_name'], r['id']] }
  end
end
