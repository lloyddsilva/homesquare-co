class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :alias
      t.string :slug
      t.text :description
      t.integer :neighborhood_id

      t.timestamps
    end

    add_index :apartments, :slug, :unique => true
  end
end
