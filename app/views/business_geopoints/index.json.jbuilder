json.array!(@business_geopoints) do |business_geopoint|
  json.extract! business_geopoint, :id, :business_id, :geopoint_id
  json.url business_geopoint_url(business_geopoint, format: :json)
end
