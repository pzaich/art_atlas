json.array! @paintings do |painting|
  json.id painting.id
  json.name painting.name
  json.thumbnail_url painting.image.url(:thumb)
  json.full_image_url painting.image.url(:original)
  json.artist do
    json.name painting.artist.name
  end
end

