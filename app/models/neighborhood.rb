class Neighborhood < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]
  	
	has_paper_trail

	has_many :apartments
	has_many :businesses
	has_many :users, :through => :apartments

	belongs_to :city

	has_many :posts, as: :postable, :dependent => :destroy
	has_many :groups, :dependent => :destroy
	has_many :events, :dependent => :destroy
end
