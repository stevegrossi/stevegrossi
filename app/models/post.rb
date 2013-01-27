# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  link_url     :string(255)
#  idea         :text
#  content      :text
#  book_id      :integer
#  slug         :string(255)
#  published_at :datetime
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Post < ActiveRecord::Base
  include Postable

  extend FriendlyId
  friendly_id :title

  include PgSearch
  multisearchable against: [:title, :idea, :content],
                  if: :published?

  attr_accessible :content, :idea, :link_url, :published_at, :title, :book_id

  belongs_to :book

  validates :title,   presence: true
  validates :idea,    presence: true
  validates :content, presence: true

  def book_post?
    book.present?
  end

  def link_post?
    link_url.present?
  end
end
