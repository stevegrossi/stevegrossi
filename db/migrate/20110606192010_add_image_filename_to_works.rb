class AddImageFilenameToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :image_filename, :string
  end

  def self.down
    remove_column :works, :image_filename
  end
end
