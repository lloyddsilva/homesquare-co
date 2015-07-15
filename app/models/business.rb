class Business < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
	
	has_paper_trail

	has_many :business_geopoints, :dependent => :destroy
	has_many :geopoints, :through => :business_geopoints

	belongs_to :neighborhood
end
