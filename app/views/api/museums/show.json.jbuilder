json.partial! 'api/museums/museum', museum: @museum

# json.paintings @paintings do |painting|
#   json.name painting.name
#   json.artist do
#     json.name painting.artist.name
#   end
# end

# json.artists @museum.artists do |artist|
#   json.name artist.name
# end