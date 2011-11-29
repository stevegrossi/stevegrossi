class AddCategoryToWishlistItem < ActiveRecord::Migration
  def self.up
    add_column :wishlist_items, :category, :string
  end

  def self.down
    remove_column :wishlist_items, :category
  end
end
