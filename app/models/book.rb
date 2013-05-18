# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
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

  scope :read, where('end_date IS NOT NULL').order('end_date DESC')
  scope :unread, where('end_date IS NULL').order('start_date')
  scope :posted, includes(:post).where('posts.published_at IS NOT NULL').order('posts.published_at DESC')
  scope :unposted, includes(:post).where('posts.published_at IS NULL').order('end_date DESC')

  validates :title,       presence: true
  validates :publisher,   presence: true
  validates :pub_year,    presence: true
  validates :authors,     presence: true
  validates :start_date,  presence: true

  def posted?
    post && post.published?
  end

  def cover_url
    if cover_image.blank?
      "http://images.amazon.com/images/P/#{asin}.01.LZZZZZZZ.jpg"
    else
      "http://cloud.stevegrossi.com/books/#{cover_image}"
    end
  end

end
