class Project < ActiveRecord::Base
  attr_accessible :name

  after_create :prepare_project

  def use
    Apartment::Database.switch(name.downcase)
  end

  private

  def prepare_project
    Apartment::Database.create(name.downcase)
  end
end
