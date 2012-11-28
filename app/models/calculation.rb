class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit, :project_layer_id, :operation_id

  belongs_to :project_layer
  belongs_to :operation
end
