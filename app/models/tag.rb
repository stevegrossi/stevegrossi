# == Schema Information
#
# Table name: tags
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  
  def to_param
    name.parameterize
  end

end
