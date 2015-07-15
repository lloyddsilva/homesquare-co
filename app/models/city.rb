class City < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
  	
	has_paper_trail
	
	has_many :neighborhoods
end
