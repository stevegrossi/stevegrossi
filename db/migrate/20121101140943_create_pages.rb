class CreatePages < ActiveRecord::Migration
  # I've since learned that 'unique: true' belonged on the index,
  # not the permalink column. This is fixed in
  # 20121129122858_make_pages_permalink_index_unique.rb
  def change
    create_table :pages do |t|
      t.string :title
      t.string :permalink, unique: true
      t.text :content
      t.text :description

      t.timestamps
    end
    add_index :pages, :permalink
  end
end
