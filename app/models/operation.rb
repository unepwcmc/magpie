# == Schema Information
#
# Table name: public.operations
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Operation < ActiveRecord::Base
  attr_accessible :name
end
