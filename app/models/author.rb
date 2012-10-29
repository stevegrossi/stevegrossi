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
#  slug       :string(255)
#

class Author < ActiveRecord::Base

  extend FriendlyId
  friendly_id :full_name

  attr_accessible :fname, :mname, :lname

  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  default_scope order: 'lname, fname, mname'

  validates :fname, presence: true,
                    uniqueness: { scope: [:lname, :mname] }
  validates :lname, presence: true

  def full_name
    [fname, mname, lname].join(' ')
  end
end
