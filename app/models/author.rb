# == Schema Information
#
# Table name: authors
#
#  id         :integer(4)      not null, primary key
#  fname      :string(255)
#  mname      :string(255)
#  lname      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  
  has_friendly_id :full_name, :use_slug => true
  
  has_many :authorships, :dependent => :destroy
  has_many :books, :through => :authorships
  
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
