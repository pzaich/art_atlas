json.cache! museum do
  json.id museum.id
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.address museum.address
  json.avatar_url museum.avatar.url(:thumb)
  json.full_url museum.avatar.url(:original)
end