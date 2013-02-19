# == Schema Information
#
# Table name: books
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  publisher   :string(255)
#  pub_year    :string(255)
#  asin        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  subtitle    :string(255)
#  cover_image :string(255)
#  slug        :string(255)
#  end_date    :date
#  start_date  :date
#

class Book < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title

  attr_accessible :title, :subtitle, :asin, :publisher, :pub_year, :author_ids, :cover_image, :start_date, :end_date

  has_one :post
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  validates :title,       presence: true
  validates :publisher,   presence: true
  validates :pub_year,    presence: true
  validates :authors,     presence: true
  validates :start_date,  presence: true

end
