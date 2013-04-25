class Result < ActiveRecord::Base
  attr_accessible :value, :area_of_interest, :statistic

  belongs_to :statistic
  belongs_to :area_of_interest

  def fetch
    begin
      self.value = statistic.project_layer.class.fetch_result(statistic.operation, self.area_of_interest)
      self.error_message = self.error_stack = nil
    rescue Exception => e
      self.error_message = e.message
      self.error_stack = e.backtrace.to_s
    end
    save!
  end
end
