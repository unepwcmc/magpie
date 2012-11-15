class AppLayer < ActiveRecord::Base
  attr_accessible :id, :is_displayed, :name, :provider_id, :tile_url, :type
end
