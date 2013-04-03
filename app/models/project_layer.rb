class ProjectLayer < ActiveRecord::Base
  attr_accessible :display_name, :is_displayed, :provider_id, :type, :calculations_attributes

  has_many :calculations, dependent: :destroy
  accepts_nested_attributes_for :calculations, reject_if: lambda { |c| c[:display_name].blank? }, allow_destroy: true

  PROJECT_LAYER_CLASSES = %w( RasterLayer ProtectedPlanetLayer BlueCarbonLayer )

  def self.subclass(subclass_type)
    project_layer_class = PROJECT_LAYER_CLASSES[PROJECT_LAYER_CLASSES.index(subclass_type).to_i]
    project_layer_class.constantize
  end

  validates :display_name, presence: true
  validates :type, inclusion: { in: PROJECT_LAYER_CLASSES, message: "is not a valid type" }
end
