class Apartment < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
  	
	has_paper_trail
	
	has_many :user_apartments, :dependent => :destroy
	has_many :users, :through => :user_apartments

	has_many :apartment_geopoints, :dependent => :destroy
	has_many :geopoints, :through => :apartment_geopoints

	belongs_to :neighborhood

	has_many :posts, as: :postable, :dependent => :destroy

end
