class WishlistItem < ActiveRecord::Base
end

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
#

