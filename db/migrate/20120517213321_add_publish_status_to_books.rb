class AddPublishStatusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :publish_status, :string, :default => 'published'
  end
end
