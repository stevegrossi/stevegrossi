class RemoveWritings < ActiveRecord::Migration
  def up
    drop_table :writings
  end

  def down
    create_table :writings do |t|
      t.string   :title
      t.text     :content
      t.string   :summary
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :published_at
      t.string   :slug
    end
  end
end
