class AddPublishStatusToWritings < ActiveRecord::Migration
  def change
    add_column :writings, :publish_status, :string, :default => 'published'
  end
end
