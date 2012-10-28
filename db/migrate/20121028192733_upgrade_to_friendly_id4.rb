class UpgradeToFriendlyId4 < ActiveRecord::Migration
  def up
    drop_table :slugs

    add_column :tags,     :slug, :string
    add_column :works,    :slug, :string
    add_column :writings, :slug, :string
    add_column :books,    :slug, :string
    add_column :authors,  :slug, :string

    add_index :tags,      :slug, unique: true
    add_index :works,     :slug, unique: true
    add_index :writings,  :slug, unique: true
    add_index :books,     :slug, unique: true
    add_index :authors,   :slug, unique: true

    Tag.find_each(&:save)
    Work.find_each(&:save)
    Writing.find_each(&:save)
    Book.find_each(&:save)
    Author.find_each(&:save)
  end

  def down
    create_table :slugs do |t|
      t.string :name
      t.integer :sluggable_id
      t.integer :sequence, null: false, default: 1
      t.string :sluggable_type, limit: 40
      t.string :scope
      t.datetime :created_at
    end
    add_index :slugs, :sluggable_id
    add_index :slugs, [:name, :sluggable_type, :sequence, :scope], name: "index_slugs_on_n_s_s_and_s", unique: true

    remove_column :tags,     :slug
    remove_column :works,    :slug
    remove_column :writings, :slug
    remove_column :books,    :slug
    remove_column :authors,  :slug

    remove_index :tags,      :slug
    remove_index :works,     :slug
    remove_index :writings,  :slug
    remove_index :books,     :slug
    remove_index :authors,   :slug

    Tag.find_each(&:save)
    Work.find_each(&:save)
    Writing.find_each(&:save)
    Book.find_each(&:save)
    Author.find_each(&:save)
  end
end
