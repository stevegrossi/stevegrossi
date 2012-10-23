# == Schema Information
#
# Table name: books
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  author       :string(255)
#  publisher    :string(255)
#  pub_year     :string(255)
#  asin         :string(255)
#  thoughts     :text
#  created_at   :datetime
#  updated_at   :datetime
#  subtitle     :string(255)
#  cover_image  :string(255)
#  thesis       :text
#  published_at :datetime
#

class Book < ActiveRecord::Base

  include PgSearch
  multisearchable against: [:title, :subtitle, :thesis, :thoughts]

  acts_as_taggable_on :topics

  include Postable

  has_friendly_id :title, use_slug: true

  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  validates :title,           presence: true
  validates :publisher,       presence: true
  validates :pub_year,        presence: true
  validates :thoughts,        presence: true
  validates :authors,         presence: true

end
