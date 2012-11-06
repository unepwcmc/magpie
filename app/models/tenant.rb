class Tenant < ActiveRecord::Base
  attr_accessible :name, :subdomain

  after_create :prepare_tenant

  private

  def prepare_tenant
    Apartment::Database.create(name)
  end

end
