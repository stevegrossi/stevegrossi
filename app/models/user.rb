# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  birthdate       :date
#

class User < ActiveRecord::Base
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :username
  validates_uniqueness_of :username

  def days_alive
    if birthdate?
      (Date.today - birthdate).to_i
    else
      0
    end
  end
end
