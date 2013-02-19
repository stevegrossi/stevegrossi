class AddReadFieldsToBooks < ActiveRecord::Migration
  def up
    rename_column :books, :read_on, :end_date
    add_column    :books, :start_date, :date
    remove_column :books, :published_at
    Book.update_all('start_date = end_date')
  end
  def down
    rename_column :books, :end_date, :read_on
    remove_column :books, :start_date
    add_column    :books, :published_at, :datetime
  end
end
