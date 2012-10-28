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
#  slug           :string(255)
#

class Work < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title

  attr_accessible :title, :about, :image_filename

  include Postable

  validates :title,           presence: true
  validates :about,           presence: true
  validates :image_filename,  presence: true

end
