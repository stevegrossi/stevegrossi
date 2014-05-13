class DropWorks < ActiveRecord::Migration
  def up
    drop_table :works
  end

  def down
    create_table :works do |t|
      t.string   :title
      t.text     :about
      t.string   :url
      t.string   :client
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :image_filename
      t.datetime :published_at
      t.string   :slug

      t.timestamps
    end
    add_index :works, :slug, unique: true
  end
end
