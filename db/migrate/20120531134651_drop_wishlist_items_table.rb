class DropWishlistItemsTable < ActiveRecord::Migration
  def up
    drop_table :wishlist_items
  end

  def self.up
    create_table :wishlist_items do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :image_url
      t.decimal :price, :precision => 8, :scale => 2
      t.string :purchase_at
      t.boolean :purchased, :default => false

      t.timestamps
    end
  end
end
