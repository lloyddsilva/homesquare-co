json.array!(@groups) do |group|
  json.extract! group, :id, :name, :description, :visibility
  json.url group_url(group, format: :json)
end
