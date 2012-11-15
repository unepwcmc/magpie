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

require 'spec_helper'

describe AppLayer do
  pending "add some examples to (or delete) #{__FILE__}"
end
