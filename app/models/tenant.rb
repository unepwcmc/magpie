# == Schema Information
#
# Table name: public.tenants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
