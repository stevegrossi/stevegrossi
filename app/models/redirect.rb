class Redirect < ActiveRecord::Base

  validates :from,  presence: true,
                    uniqueness: true
  validates :to,    presence: true,
                    format: { with: URI.regexp(%w(http https)) }
end
