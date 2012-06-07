# == Schema Information
#
# Table name: books
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  author         :string(255)
#  publisher      :string(255)
#  pub_year       :string(255)
#  asin           :string(255)
#  thoughts       :text
#  created_at     :datetime
#  updated_at     :datetime
#  subtitle       :string(255)
#  cover_image    :string(255)
#  publish_status :string(255)     default("published")
#  thesis         :text
#

class Book < ActiveRecord::Base

  acts_as_taggable_on :topics
  
  include Postable
  
  has_friendly_id :title, :use_slug => true
  
  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships

  validates :title,           :presence => true
  validates :author,          :presence => true
  validates :publisher,       :presence => true
  validates :pub_year,        :presence => true
  validates :thoughts,        :presence => true
  
end