class MakePagesPermalinkIndexUnique < ActiveRecord::Migration
  def up
    remove_index :pages, :permalink
    add_index :pages, :permalink, unique: true
  end

  def down
    remove_index :pages, :permalink
    add_index :pages, :permalink
  end
end
