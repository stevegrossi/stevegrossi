# == Schema Information
#
# Table name: writings
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  content      :text
#  summary      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  published_at :datetime
#

class Writing < ActiveRecord::Base

  attr_accessible :title, :content, :summary, :published_at

  include PgSearch
  multisearchable :against => [:title, :content, :summary]

  include Postable

  has_friendly_id :title, :use_slug => true

  validates :title,           presence: true
  validates :content,         presence: true
  validates :summary,         presence: true

end
