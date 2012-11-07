class Tenant < ActiveRecord::Base
  attr_accessible :name, :subdomain

  has_many :tenant_layers
  has_many :layers, :through => :tenant_layers

  after_create :prepare_tenant

  private

  def prepare_tenant
    Apartment::Database.create(name)
  end

end
