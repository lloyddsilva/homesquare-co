json.array!(@geopoints) do |geopoint|
  json.extract! geopoint, :id, :address, :street_name, :block_number, :postal_code, :latitude, :longitude
  json.url geopoint_url(geopoint, format: :json)
end
