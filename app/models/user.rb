class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :registerable, :rememberable, :trackable,
         :validatable, :lockable

  def days_alive
    if birthdate?
      (Date.current - birthdate).to_i
    else
      0
    end
  end
end
