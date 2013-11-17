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
end