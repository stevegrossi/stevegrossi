class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :pub_year
      t.string :asin
      t.text :thoughts

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
