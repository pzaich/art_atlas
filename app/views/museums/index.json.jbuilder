json.museums @museums do |museum|
  json.id museum.id
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.address museum.address
  json.museum_url museum_path(museum, query: params[:query])
end
json.total @museums.count
json.url request.fullpath
json.title museum_page_title(params)
json.flash_message render 'shared/flash.html.haml', flash: flash

