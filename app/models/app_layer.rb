# == Schema Information
#
# Table name: app_layers
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  type         :string(255)      not null
#  provider_id  :integer          not null
#  tile_url     :string(255)      not null
#  is_displayed :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AppLayer < ActiveRecord::Base
  attr_accessible :id, :is_displayed, :display_name, :provider_id, :tile_url, :type
  has_many :calculations
end
class RasterLayer < AppLayer; end
