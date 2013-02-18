class RemoveUnusedAttributesFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :thesis
    remove_column :books, :thoughts
  end

  def down
    add_column :books, :thesis, :text
    add_column :books, :thoughts, :text
  end
end
