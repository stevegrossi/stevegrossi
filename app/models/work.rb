# == Schema Information
#
# Table name: works
#
#  id             :integer         not null, primary key
#  title          :string(255)
#  about          :text
#  url            :string(255)
#  client         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  image_filename :string(255)
#  published_at   :datetime
#

class Work < ActiveRecord::Base

  include Postable

  has_friendly_id :title, use_slug: true

  validates :title,           presence: true
  validates :about,           presence: true
  validates :image_filename,  presence: true

end