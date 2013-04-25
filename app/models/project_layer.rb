class ProjectLayer < ActiveRecord::Base
  attr_accessible :display_name, :is_displayed, :provider_id, :type, :statistics_attributes

  has_many :statistics, dependent: :destroy
  accepts_nested_attributes_for :statistics, reject_if: lambda { |c| c[:display_name].blank? }, allow_destroy: true

  PROJECT_LAYER_CLASSES = %w( RasterLayer ProtectedPlanetLayer BlueCarbonLayer )

  def self.subclass(subclass_type)
    project_layer_class = PROJECT_LAYER_CLASSES[PROJECT_LAYER_CLASSES.index(subclass_type).to_i]
    project_layer_class.constantize
  end

  def self.get_operations
    class_name  = self.to_s.underscore
    module_name = "#{class_name}_operations"
    operations  = []

    Dir.chdir("#{Rails.root}/lib/modules/") do |dir|
      id = 0
      Dir["#{module_name}/**"].each do |file|
        next if File.basename(file, '.rb') == module_name

        operation_module = file.chomp(File.extname(file)).camelize.constantize
        operations << {
          'id'           => id,
          'name'         => operation_module::Name,
          'display_name' => operation_module::DisplayName
        }

        id += 1
      end
    end

    operations
  end

  def self.get_providers
    []
  end

  def self.fetch_result(operation, area_of_interest)
    "#{self}Operations::#{operation.to_s.classify}".constantize.perform(area_of_interest)
  end

  validates :display_name, presence: true
  validates :type, inclusion: { in: PROJECT_LAYER_CLASSES, message: "is not a valid type" }
end
