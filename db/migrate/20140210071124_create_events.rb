class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :alias
      t.string :slug
      t.string :venue
      t.date :event_date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :owner_id
      t.integer :neighborhood_id

      t.timestamps
    end
  end
end
