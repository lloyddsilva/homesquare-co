class AddAdvancedFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :gender, :string
  	add_column :users, :birthday, :date
  	add_column :users, :about_me, :text
    add_column :users, :resident_since, :date
  	add_column :users, :home_town, :string
  	add_column :users, :education, :string
  	add_column :users, :occupation, :string
  	add_column :users, :interests, :text
  	add_column :users, :fav_thing_neighborhood, :string
  	add_column :users, :fav_thing_apartment, :string
  	add_column :users, :fav_restaurant, :string
  	add_column :users, :fav_hangout, :string
  end
end
