class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.text :description
      t.string :alias
      t.string :slug
      t.integer :city_id

      t.timestamps
    end

    add_index :neighborhoods, :slug, :unique => true
  end
end
