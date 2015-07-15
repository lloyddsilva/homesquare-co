json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :name, :alias, :slug, :description, :neighborhood_id
  json.url apartment_url(apartment, format: :json)
end
