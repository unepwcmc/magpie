class App < ActiveRecord::Base
  attr_accessible :id, :name

  after_create :prepare_app

  private

  def prepare_app
    Apartment::Database.create(name)
  end

end
