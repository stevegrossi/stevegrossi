# == Schema Information
#
# Table name: pages
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  permalink   :string(255)
#  content     :text
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Page < ActiveRecord::Base
  attr_accessible :title, :permalink, :content, :description

  validates :title,     presence: true,
                        uniqueness: true
  validates :permalink, presence: true,
                        uniqueness: true
  validates :content,   presence: true

  def to_param
    permalink
  end
end
