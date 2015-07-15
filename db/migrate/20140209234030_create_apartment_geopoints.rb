class CreateApartmentGeopoints < ActiveRecord::Migration
  def change
    create_table :apartment_geopoints do |t|
      t.integer :apartment_id
      t.integer :geopoint_id

      t.timestamps
    end
  end
end
