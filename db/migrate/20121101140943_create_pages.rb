class CreatePages < ActiveRecord::Migration
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
