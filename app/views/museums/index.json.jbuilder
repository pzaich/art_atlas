json.museums @museums do |museum|  
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.address museum.address
  json.infobox render 'museums/infobox.html.haml', :museum => museum
end
json.total @museums.count
