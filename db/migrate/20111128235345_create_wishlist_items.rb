class CreateWishlistItems < ActiveRecord::Migration
  def self.up
    create_table :wishlist_items do |t|
      t.string :name
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
      t.string :purchase_at
      t.boolean :purchased, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :wishlist_items
  end
end
