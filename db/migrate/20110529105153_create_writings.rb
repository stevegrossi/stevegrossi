class CreateWritings < ActiveRecord::Migration
  def self.up
    create_table :writings do |t|
      t.string :title
      t.text :content
      t.string :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :writings
  end
end
