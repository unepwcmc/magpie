class Result < ActiveRecord::Base
  attr_accessible :value

  belongs_to :calculation
  belongs_to :area_of_interest

  RESULT_CLASSES = %w( FloatResult JsonResult )

  validates :type, inclusion: { in: RESULT_CLASSES, message: "is not a valid type" }

  def self.generate(area_of_interest, calculation)
    result = area_of_interest.results.find(:first, conditions: { calculation_id: calculation.id })

    unless result
      self.create_for_area_of_interest_and_calculation(area_of_interest, calculation)
    end

    begin
      result.fetch
    rescue TimeoutError => e
      result.errors[:base] <<e.message
    end
  end

  def self.create_for_area_of_interest_and_calculation(area_of_interest, calculation)
    result = calculation.new_result

    result.area_of_interest_id = area_of_interest.id
    result.save
    return result
  end
end
