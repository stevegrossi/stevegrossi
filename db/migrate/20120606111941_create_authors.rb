class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :fname
      t.string :mname
      t.string :lname

      t.timestamps
    end
  end
end
