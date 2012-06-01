class AddPublishStatusToWorks < ActiveRecord::Migration
  def change
    add_column :works, :publish_status, :string, :default => 'published'
  end
end