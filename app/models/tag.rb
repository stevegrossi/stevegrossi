# == Schema Information
#
# Table name: tags
#
#  id   :integer         not null, primary key
#  name :string(255)
#  slug :string(255)
#

class Tag < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name

end
