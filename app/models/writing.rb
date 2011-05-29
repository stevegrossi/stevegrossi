# == Schema Information
#
# Table name: writings
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  content    :text
#  summary    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Writing < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
end