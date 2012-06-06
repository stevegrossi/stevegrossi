class Author < ActiveRecord::Base
  
  has_friendly_id :full_name, :use_slug => true
  
  # should use first name next
  default_scope :order => 'lname, fname, mname'
  
  validates :fname, :presence => true
  validates :lname, :presence => true
  
  def full_name
    name = fname
    name += ' ' + mname unless mname.blank?
    name += ' ' + lname
  end
end