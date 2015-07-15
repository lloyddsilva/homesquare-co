class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.string :alias
      t.string :slug
      t.integer :neighborhood_id
      t.string :visibility
      t.integer :owner_id

      t.timestamps
    end
  end
end
