class BusinessGeopoint < ActiveRecord::Base
	belongs_to :business 
	belongs_to :geopoint
end
