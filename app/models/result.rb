class Result < ActiveRecord::Base
  attr_accessible :value

  belongs_to :calculation
  belongs_to :area_of_interest

  RESULT_CLASSES = %w( FloatResult JsonResult )

  validates :type, inclusion: { in: RESULT_CLASSES, message: "is not a valid type" }

  def self.generate(area_of_interest, calculation)
    result = area_of_interest.results.find(:first, conditions: { calculation_id: calculation.id })

    unless result
      result_class = calculation.project_layer.class.result_class(calculation.operation)
      result = result_class.new
      result.area_of_interest_id = area_of_interest.id
      result.calculation_id = calculation.id
      result.save
    end

    begin
      result.fetch
    rescue TimeoutError => e
      result.errors.add_to_base(e.message)
    end
  end
end
