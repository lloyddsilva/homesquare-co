class Geopoint < ActiveRecord::Base
	has_paper_trail

	has_many :apartment_geopoints, :dependent => :destroy
	has_many :apartments, :through => :apartment_geopoints

	has_many :business_geopoints, :dependent => :destroy
	has_many :businesses, :through => :business_geopoints

	after_validation :geocode, :reverse_geocode, :if => :address_changed?

	geocoded_by :address

	reverse_geocoded_by :latitude, :longitude do |obj,results|
		logger.debug "DEBUG::#{results}"
		if geo = results.first
			@user_city = City.find_or_create_by_name_and_country(geo.city.titleize, geo.country.titleize, :alias => geo.city.titleize, :description => geo.city.titleize, :state => geo.state)
			obj.postal_code = geo.postal_code
			obj.street_name = geo.route
			obj.block_number = geo.street_number
			obj.address = geo.formatted_address


			# Lookup neighborhood
			if !geo.neighborhood.blank?
				@lookup_neighborhood = geo.neighborhood
			else
				if !geo.address_components_of_type('sublocality').blank?
					@lookup_neighborhood = geo.address_components_of_type('sublocality').first['long_name']
				else
					if !geo.address_components_of_type('locality').blank?
						@lookup_neighborhood = geo.address_components_of_type('locality').first['long_name']
					end
				end
			end

			# Attach neighborhood
			if !@lookup_neighborhood.blank?
				@user_neighborhood = Neighborhood.find_or_create_by_name(@lookup_neighborhood.titleize, :alias => @lookup_neighborhood.titleize, :description => @lookup_neighborhood.titleize, :city_id => @user_city.id)
				# obj.neighborhood_id = @user_neighborhood.id
			end

			# Lookup apartment

			# Add if condition for Singapore only
			
		    if geo.country == "Singapore"
		      one_map_access_key = "RkLWeAKlDdNP9Y2AmVSx3GPJbegT6GnQrTiweEIyhmfvgReBbUZeEbFi30eEj3z2V1pUcI88iyMEDXrT+blB6quzjuU2YaEMAS4H7OwgarCYCBdoM5zimQ==|mv73ZvjFcSo="
		      one_map_token_url = "http://www.onemap.sg/API/services.svc/getToken?accessKEY=#{one_map_access_key}"
		      one_map_token_uri = URI.escape(one_map_token_url)
		      one_map_token_json_obj = JSON.parse(open("#{one_map_token_uri}").read)
		      logger.debug "DEBUG::#{one_map_token_json_obj}"

		      # Get building name via reverse geocoding
		      if !one_map_token_json_obj.blank?
		        one_map_token = one_map_token_json_obj["GetToken"][0]["NewToken"]
		      else
		        one_map_token = "xSE9mMeToEtAUjzaxFRk+wm5QuduWs6tmTccr/8tmBZCkAEPNE40zttzBMLTvLpFAdM0yc0XgGr6Uo2Xo4I5Th6ja3iUhoX939sgxjrKMan/DAQST6guTw=="
		      end
		      logger.debug "DEBUG::#{one_map_token}"
		      
		      # latitude = "1.297463"
		      # longitude = "103.874445"
		      one_map_result_url = "http://www.onemap.sg/API/services.svc/revgeocode?token=#{one_map_token}&location=#{geo.longitude},#{geo.latitude}"
		      one_map_result_uri = URI.escape(one_map_result_url)
		      one_map_result_json_obj = JSON.parse(open(one_map_result_uri).read)
		      logger.debug "DEBUG::#{one_map_result_uri}"
		      logger.debug "DEBUG::#{one_map_result_json_obj}"

		      if !one_map_result_json_obj.blank?
		        building_name = one_map_result_json_obj["GeocodeInfo"][0]["BUILDINGNAME"]  
		      end

		    end


			# Attach apartment
			logger.debug "DEBUG::#{building_name}"
			if !building_name.blank?
		          @user_apartment = Apartment.find_or_create_by_name(building_name.titleize, :alias => building_name.titleize, :description => building_name.titleize, :neighborhood_id => @user_neighborhood.id)
		          obj.apartments << @user_apartment
		    else
		    	  if !geo.address_components_of_type('premise').blank?
					building_name = geo.address_components_of_type('premise').first['long_name']
				  end
				  if building_name.blank?
		    	  	building_name = [geo.street_number, geo.route].join(' ')				  	
				  end
				  building_name.titleize unless building_name.blank?
			      logger.debug "DEBUG::#{building_name}"
			      @user_apartment = Apartment.find_or_create_by_name(building_name, :alias => building_name, :description => building_name, :neighborhood_id => @user_neighborhood.id)
		          obj.apartments << @user_apartment
		    end

		end
	end

end
