class Analysis < ActiveRecord::Base
  attr_accessible :name
  has_many :areas, :order => 'is_summary ASC, created_at'
  has_many :polygons, :through => :areas

  after_create :prepare_summary

  private
  def prepare_summary
    areas << Area.new(:name => 'Summary', :is_summary => true)
  end
end
