class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id
  has_many :results
  belongs_to :workspace
  has_many :polygons, :dependent => :destroy
  has_many :results, :dependent => :destroy

  def get_results
    just_finished_a_request = false
    ProjectLayer.all.each do |layer|
      layer.calculations.each do |calc|
        result = self.results.find_or_create_by_calculation_id(calc.id)
        if result.updated_at > self.latest_polygon.updated_at || !result.value || result.value == 0.0
          if layer.type == 'RasterLayer'
            result.get
            just_finished_a_request = true
          #elsif layer.type == 'CartoDbLayer'
          end
        end
      end
    end
  end

  def latest_polygon
    self.polygons.order(:updated_at).limit(1).first
  end
end
