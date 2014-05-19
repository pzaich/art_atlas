json.id museum.id
json.name museum.name
json.latitude museum.latitude
json.longitude museum.longitude
json.address museum.address
json.avatar_url museum.avatar(:thumb)
json.museum_url museum_path(museum, query: params[:query])