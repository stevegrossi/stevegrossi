class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
  end
end
