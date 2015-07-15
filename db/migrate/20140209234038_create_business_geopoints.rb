class CreateBusinessGeopoints < ActiveRecord::Migration
  def change
    create_table :business_geopoints do |t|
      t.integer :business_id
      t.integer :geopoint_id

      t.timestamps
    end
  end
end
