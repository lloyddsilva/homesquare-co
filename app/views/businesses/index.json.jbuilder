json.array!(@businesses) do |business|
  json.extract! business, :id, :name, :alias, :slug, :description, :neighborhood_id
  json.url business_url(business, format: :json)
end
