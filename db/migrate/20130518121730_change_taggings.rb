class ChangeTaggings < ActiveRecord::Migration
  def up
    remove_column :taggings, :taggable_type
    remove_column :taggings, :tagger_type
    remove_column :taggings, :tagger_id
    remove_column :taggings, :context

    rename_column :taggings, :taggable_id, :post_id
  end

  def down
    add_column :taggings, :taggable_type, :string
    add_column :taggings, :tagger_type, :string
    add_column :taggings, :tagger_id, :integer
    add_column :taggings, :context, :string

    rename_column :taggings, :post_id, :taggable_id
  end
end
