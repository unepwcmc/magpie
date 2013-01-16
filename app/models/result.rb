class Result < ActiveRecord::Base
  attr_accessible :value

  belongs_to :calculation
  belongs_to :area_of_interest

  RESULT_CLASSES = %w( FloatResult JsonResult )

  validates :type, inclusion: { in: RESULT_CLASSES, message: "is not a valid type" }

  def self.generate(area_of_interest, calculation)
    unless area_of_interest.results.count(:all, conditions: { calculation_id: calculation.id })
      result_class = calculation.project_layer.class.result_class(calculation.operation)
      result = result_class.create({calculation_id: calculation.id})
      result.fetch
    end
  end
end
