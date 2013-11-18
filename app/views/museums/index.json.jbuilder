json.museums @museums do |museum|
  json.id museum.id  
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.address museum.address
  json.infobox render 'museums/infobox.html.haml', :museum => museum
  json.dialog_link museum_path(museum, query: params[:query])
end
json.total @museums.count
json.url request.fullpath
json.title museum_page_title(params)
