module Postable
  
  PUBLISH_STATES = ['published', 'draft']
  
  def self.included(base)
    base.class_eval do
      default_scope :order => 'created_at DESC'
      scope :published, where(:publish_status => 'published')
      scope :drafts, where(:publish_status => 'draft')
      validates :publish_status,  :inclusion => { :in => PUBLISH_STATES },
                                  :presence => true
    end
  end
  
  def previous
    self.class.published.where('created_at < ?', self.created_at).first
  end

  def next
    self.class.published.where('created_at > ?', self.created_at).last
  end
  
  def draft?
    publish_status == 'draft'
  end
  
  def published?
    publish_status == 'published'
  end
  
  def date_created
    created_at.to_date.strftime('%-m/%-e/%Y')
  end
end