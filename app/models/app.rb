# == Schema Information
#
# Table name: public.apps
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class App < ActiveRecord::Base
  attr_accessible :id, :name
  after_create :prepare_app

  def use
    Apartment::Database.switch(name.downcase)
  end

  private

  def prepare_app
    Apartment::Database.create(name.downcase)
  end

end
