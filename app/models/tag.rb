class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  extend FriendlyId
  friendly_id :name

  default_scope { order("name") }

end
