json.array!(@apartment_geopoints) do |apartment_geopoint|
  json.extract! apartment_geopoint, :id, :apartment_id, :geopoint_id
  json.url apartment_geopoint_url(apartment_geopoint, format: :json)
end
