# == Schema Information
#
# Table name: works
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  about          :text
#  url            :string(255)
#  client         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  image_filename :string(255)
#  publish_status :string(255)     default("published")
#

class Work < ActiveRecord::Base
  
  include Postable
  
  has_friendly_id :title, :use_slug => true

  validates :title,           :presence => true
  validates :about,           :presence => true
  validates :image_filename,  :presence => true

end