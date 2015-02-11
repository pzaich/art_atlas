namespace :update do
  require 'open-uri'
  desc 'load paintings by artist'

  task :museum_geocoding => :environment do
    count = 0
    Museum.unscoped.uncoded.each do |museum|
      sleep 1
      museum.geocode
      if museum.latitude && museum.save
        puts "museum geocoded"
        count += 1
      else
        puts "no coordinates found"
      end
    end
    puts "#{count} museums geocoded"
  end

  task :museum_thumbs => :environment do
    Museum.unscoped.find_each do |museum|
      MuseumThumbGenerator.new(museum)
    end
  end
end