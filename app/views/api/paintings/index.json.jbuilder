json.array! @paintings do |painting|
  json.id painting.id
  json.name painting.name
  json.full_image_url painting.image.url(:large)
  json.artist do
    json.name painting.artist.name
  end
end

