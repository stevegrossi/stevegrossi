class AddThesisToBooks < ActiveRecord::Migration
  def change
    add_column :books, :thesis, :text
  end
end
