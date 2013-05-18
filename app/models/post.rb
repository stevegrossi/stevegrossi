# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  link_url     :string(255)
#  idea         :text
#  content      :text
#  book_id      :integer
#  slug         :string(255)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  word_count   :integer
#

class Post < ActiveRecord::Base

  paginates_per 20

  include Postable

  extend FriendlyId
  friendly_id :title

  include PgSearch
  multisearchable against: [:title, :idea, :content],
                  if: :published?

  attr_accessible :content, :idea, :link_url, :published_at, :title, :book_id, :tag_list

  belongs_to :book
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title,   presence: true
  validates :idea,    presence: true
  validates :content, presence: true

  before_validation :set_title_to_book_title
  before_save :set_word_count

  def set_title_to_book_title
    if title.blank? && book_post?
      self.title = book.title
    end
  end

  scope :book_posts, where("book_id IS NOT NULL")
  scope :link_posts, where("link_url IS NOT NULL AND link_url != ''")
  scope :writing_posts, where("(link_url IS NULL OR link_url = '') AND book_id IS NULL")

  def post_type
    if book_post?
      'Book'
    elsif link_post?
      'Link'
    else
      'Writing'
    end
  end

  def book_post?
    book.present?
  end

  def link_post?
    link_url.present?
  end

  def count_words
    content.scan(/\S+/).size
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.tagged_with(tag)
    tag.posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id, tags.id, tags.name, tags.slug")
  end

  private

  def set_word_count
    self.word_count = count_words
  end

end
