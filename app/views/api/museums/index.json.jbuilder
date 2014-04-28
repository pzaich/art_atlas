json.array! @museums do |museum|
  json.id museum.id  
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.address museum.address
  json.avatar_url museum.avatar(:thumb)
  json.dialog_link museum_path(museum, query: params[:query])
end

