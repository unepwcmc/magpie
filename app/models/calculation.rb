class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit, :operation, :project_layer_id

  belongs_to :project_layer
end
