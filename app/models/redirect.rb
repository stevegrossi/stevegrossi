# == Schema Information
#
# Table name: redirects
#
#  id         :integer         not null, primary key
#  from       :string(255)
#  to         :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Redirect < ActiveRecord::Base
  attr_accessible :from, :to

  validates :from,  presence: true,
                    uniqueness: true
  validates :to,    presence: true,
                    format: { with: URI::regexp(%w(http https)) }
end
