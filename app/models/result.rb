class Result < ActiveRecord::Base
  attr_accessible :value

  belongs_to :calculation
  belongs_to :area_of_interest

  def fetch
    self.value = calculation.project_layer.fetch_result(self)
    save
  end
end
