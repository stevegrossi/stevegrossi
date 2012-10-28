# == Schema Information
#
# Table name: authors
#
#  id         :integer         not null, primary key
#  fname      :string(255)
#  mname      :string(255)
#  lname      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base

  attr_accessible :fname, :mname, :lname

  has_friendly_id :full_name, use_slug: true

  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  default_scope order: 'lname, fname, mname'

  validates :fname, presence: true,
                    uniqueness: { scope: [:lname, :mname] }
  validates :lname, presence: true

  def full_name
    name = fname
    name += ' ' + mname unless mname.blank?
    name += ' ' + lname
  end
end
