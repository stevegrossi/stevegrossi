class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.string :title
      t.text :about
      t.string :url
      t.string :client

      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
