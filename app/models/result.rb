class Result < ActiveRecord::Base
  attr_accessible :value, :area_of_interest, :statistic

  belongs_to :statistic
  belongs_to :area_of_interest

  def fetch
    self.value_json = statistic.project_layer.class.fetch_result(statistic.operation, self.area_of_interest)
    save!
  end
end
