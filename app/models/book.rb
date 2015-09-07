class Book < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title

  has_one :post
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  scope :read, -> { where("end_date IS NOT NULL").order("end_date DESC") }
  scope :unread, -> { where("end_date IS NULL").order("start_date") }
  scope :unposted, -> { joins(:post).merge(Post.drafts).order("end_date DESC") }
  scope :posted, -> { joins(:post).merge(Post.published).order("published_at DESC") }

  validates :title,       presence: true
  validates :publisher,   presence: true
  validates :pub_year,    presence: true
  validates :authors,     presence: true
  validates :start_date,  presence: true

  def posted?
    post.try(&:published?)
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
    self.end_date = Date.current
  end

  def publine
    "#{publisher}, #{pub_year}"
  end

  def year_read
    (end_date || start_date).year
  end

end
