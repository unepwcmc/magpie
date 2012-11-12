class TenantLayer < ActiveRecord::Base
  attr_accessible :layer_id

  belongs_to :layer
end
