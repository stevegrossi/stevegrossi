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
#  slug         :string(255)
#

class Writing < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title

  attr_accessible :title, :content, :summary, :published_at

  include PgSearch
  multisearchable :against => [:title, :content, :summary],
                  :if => :published?

  include Postable

  validates :title,           presence: true
  validates :content,         presence: true
  validates :summary,         presence: true

end
