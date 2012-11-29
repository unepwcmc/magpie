class ProjectLayer < ActiveRecord::Base
  attr_accessible :display_name, :is_displayed, :provider_id, :type, :calculations_attributes
  has_many :calculations, dependent: :destroy
  accepts_nested_attributes_for :calculations, reject_if: lambda { |c| c[:display_name].blank? }, allow_destroy: true
end
