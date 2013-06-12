json.museums @museums do |json, museum|  
  json.name museum.name
  json.latitude museum.latitude
  json.longitude museum.longitude
  json.marker_template j(render 'museums/infobox.html.haml', :museum => museum)
end
json.total @museums.count
