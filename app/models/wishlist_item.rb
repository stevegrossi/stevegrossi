# == Schema Information
#
# Table name: wishlist_items
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(8, 2)
#  purchase_at :string(255)
#  purchased   :boolean(1)      default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  category    :string(255)
#

class WishlistItem < ActiveRecord::Base
  
  cattr_accessor(:categories) { [ 'Goods', 'Books', 'Clothes' ] }
  delegate :categories, :to => "self.class"
  
  scope :goods,   where(:category => 'Goods')
  scope :books,   where(:category => 'Books')
  scope :clothes, where(:category => 'Clothes')
  
  validates :name,      :presence => true
  validates :category,  :inclusion => { :in => categories },
                        :presence => true
  
end