class AddPublishedAtToWritingsBooksWorks < ActiveRecord::Migration
  def change
    add_column :writings, :published_at, :datetime, :default => nil
    add_column :books, :published_at, :datetime, :default => nil
    add_column :works, :published_at, :datetime, :default => nil
  end
end