json.array!(@user_apartments) do |user_apartment|
  json.extract! user_apartment, :id, :user_id, :apartment_id, :membership, :status
  json.url user_apartment_url(user_apartment, format: :json)
end
