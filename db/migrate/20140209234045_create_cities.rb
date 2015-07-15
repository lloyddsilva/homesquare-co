class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.text :description
      t.string :alias
      t.string :slug
      t.string :country
      t.string :state

      t.timestamps
    end

    add_index :cities, :slug, :unique => true
  end
end
