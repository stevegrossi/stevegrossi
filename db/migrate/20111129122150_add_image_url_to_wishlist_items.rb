class AddImageUrlToWishlistItems < ActiveRecord::Migration
  def self.up
    add_column :wishlist_items, :image_url, :string
  end

  def self.down
    remove_column :wishlist_items, :image_url
  end
end
