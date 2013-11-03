# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
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

  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  default_scope -> { order('lower(lname), fname, mname') }

  validates :fname, presence: true,
                    uniqueness: { scope: [:lname, :mname] }
  validates :lname, presence: true

  def full_name
    [fname, mname, lname].compact.join(' ')
  end
end
