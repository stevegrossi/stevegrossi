module Postable
  
  def self.included(base)
    base.class_eval do
      default_scope :order => 'published_at DESC'
      scope :published, where('published_at IS NOT NULL')
      scope :drafts, where('published_at IS NULL')
    end
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
    !published_at.nil?
  end
  
  def pretty_published_at
    published_at.nil? ? 'Unpublished' : published_at.strftime('%-m/%-e/%Y')
  end
  
  
end