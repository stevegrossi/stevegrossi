class AddReadOnToBooks < ActiveRecord::Migration
  def up
    add_column :books, :read_on, :date
    Book.update_all('read_on = published_at')
  end
  def down
    remove_column :books, :read_on
  end
end
