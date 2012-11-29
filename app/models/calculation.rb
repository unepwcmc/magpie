class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit, :project_layer_id, :operation

  belongs_to :project_layer
end
