# == Schema Information
#
# Table name: works
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  about      :text
#  url        :string(255)
#  client     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Work < ActiveRecord::Base
end