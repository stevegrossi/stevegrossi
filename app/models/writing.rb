# == Schema Information
#
# Table name: writings
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  content        :text
#  summary        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  publish_status :string(255)     default("published")
#
class Writing < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  PUBLISH_STATUSES = ['published', 'draft']

  validates :title, :presence => true
  validates :content, :presence => true
  validates :summary, :presence => true
  validates :publish_status, :presence => true
  
  scope :published, where('publish_status' => 'published')
  
  def draft?
    publish_status = 'draft'
  end
end