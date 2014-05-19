json.array! @museums do |museum|
  json.partial! 'api/museums/museum', museum: museum
end

