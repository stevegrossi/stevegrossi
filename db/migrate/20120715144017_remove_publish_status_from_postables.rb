class RemovePublishStatusFromPostables < ActiveRecord::Migration
  def up
    remove_column :works, :publish_status
    remove_column :writings, :publish_status
    remove_column :books, :publish_status
  end
  def down
    add_column :works, :publish_status, :string, :default => 'published'
    add_column :writings, :publish_status, :string, :default => 'published'
    add_column :books, :publish_status, :string, :default => 'published'
  end
end