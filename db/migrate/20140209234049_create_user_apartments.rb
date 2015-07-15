class CreateUserApartments < ActiveRecord::Migration
  def change
    create_table :user_apartments do |t|
      t.integer :user_id
      t.integer :apartment_id
      t.string :membership
      t.string :status

      t.timestamps
    end
  end
end
