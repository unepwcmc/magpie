class ProjectLayer < ActiveRecord::Base
  attr_accessible :display_name, :is_displayed, :provider_id, :tile_url, :type

  has_many :calculations
end
