class Page < ActiveRecord::Base

  validates :title,     presence: true,
                        uniqueness: true
  validates :permalink, presence: true,
                        uniqueness: true
  validates :content,   presence: true

  include PgSearch
  multisearchable against: [:title, :content, :description]

  def to_param
    permalink
  end
end
