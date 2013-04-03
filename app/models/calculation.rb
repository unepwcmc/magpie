class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit, :operation, :project_layer_id

  belongs_to :project_layer

  def result_type
    project_layer.class
  end

  def new_result
    result_class = self.project_layer.class.result_class(self.operation)
    result = result_class.new
    result.calculation_id =  self.id
    return result
  end
end
