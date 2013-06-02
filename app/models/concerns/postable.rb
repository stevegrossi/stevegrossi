module Postable

  extend ActiveSupport::Concern

  included do
    scope :published, where('published_at IS NOT NULL').order('published_at DESC')
    scope :drafts, where('published_at IS NULL')
  end

  def previous
    self.class.published.where('created_at < ?', self.created_at).first
  end

  def next
    self.class.published.where('created_at > ?', self.created_at).last
  end

  def draft?
    published_at.nil?
  end

  def published?
    !draft?
  end

  def pretty_published_at
    published_at.nil? ? 'Unpublished' : published_at.strftime('%B %-e, %Y')
  end
end
