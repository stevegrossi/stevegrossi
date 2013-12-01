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

  has_one :post
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  scope :read, -> { where('end_date IS NOT NULL').order('end_date DESC') }
  scope :unread, -> { where('end_date IS NULL').order('start_date') }
  scope :unposted, -> { joins(:post).merge(Post.drafts).order('end_date DESC') }
  scope :posted, -> { joins(:post).merge(Post.published).order('published_at DESC') }

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

  def finished?
    end_date.present?
  end

  def finish
    self.end_date = Time.now.to_date
  end

end
