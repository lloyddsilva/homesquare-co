class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :alias
      t.string :slug
      t.text :description
      t.integer :neighborhood_id

      t.timestamps
    end

    add_index :businesses, :slug, :unique => true
  end
end
