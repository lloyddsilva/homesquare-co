json.array!(@cities) do |city|
  json.extract! city, :id, :name, :description, :alias, :slug, :country, :state
  json.url city_url(city, format: :json)
end
