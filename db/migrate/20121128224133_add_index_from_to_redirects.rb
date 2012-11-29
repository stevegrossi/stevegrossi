class AddIndexFromToRedirects < ActiveRecord::Migration
  def change
    add_index :redirects, :from, unique: true
  end
end
