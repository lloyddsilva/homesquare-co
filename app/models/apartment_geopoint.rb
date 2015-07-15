class ApartmentGeopoint < ActiveRecord::Base
	belongs_to :apartment 
	belongs_to :geopoint
end
