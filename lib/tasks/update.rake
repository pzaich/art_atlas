namespace :update do
  require 'open-uri'
  desc 'load paintings by artist'

  task :museums => :environment do
    count = 0
    Museum.unscoped.uncoded.each do |museum|
      sleep 1
      museum.geocode
      if museum.save
        puts "museum geocoded"
        count += 1
      else
        puts "no coordinates found"
      end
    end
    puts "#{count} museums geocoded"
  end

  task :museum_thumbs => :environment do
    Museum.find_each do |museum|
      begin
        if !museum.avatar.exists?
          image = open(Google::Search::Image.new(query: museum.name).first.uri)
          museum.update_attributes avatar: image
          puts "saved image for #{museum.name}"
          sleep 2
        end
      rescue
      end
    end
  end
end