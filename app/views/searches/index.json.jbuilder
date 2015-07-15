json.array!(@searches) do |search|
  json.extract! search, :id, :keywords
  json.url search_url(search, format: :json)
end
