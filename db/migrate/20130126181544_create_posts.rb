class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link_url
      t.text :idea
      t.text :content
      t.integer :book_id
      t.string :slug
      t.datetime :published_at
      t.timestamps
    end
  end
end
