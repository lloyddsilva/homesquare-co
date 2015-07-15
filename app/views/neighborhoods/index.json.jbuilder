json.array!(@neighborhoods) do |neighborhood|
  json.extract! neighborhood, :id, :name, :description, :alias, :slug, :city_id
  json.url neighborhood_url(neighborhood, format: :json)
end
