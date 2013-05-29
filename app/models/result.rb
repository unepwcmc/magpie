class Result < ActiveRecord::Base
  attr_accessible :value, :area_of_interest, :statistic

  belongs_to :statistic
  belongs_to :area_of_interest
  before_save :update_value_timestamp

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

  def update_value_timestamp
    if self.value.present? && self.changes.keys.include?('value') && 
      !self.changes.keys.include?('value_updated_at')
      self.value_updated_at = DateTime.now
    end
  end

  def has_more_recent_value_than? time
    if value.present? && time < self.value_updated_at
      return true
    else
      return false
    end
  end
end
