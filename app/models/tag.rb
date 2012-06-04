class Tag < ActiveRecord::Base
  
  def to_param
    name.parameterize
  end

end