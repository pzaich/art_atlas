namespace :generate do
  require 'open-uri'
  
  desc 'load paintings by artist'
  task :all_artists => :environment do
    page = Nokogiri::HTML(open('http://www.the-athenaeum.org/people/list.php?sort=name_up&ltr=!'))
    artist_links = page.css('.r1 .TextSmall > a') + page.css('.r2 .TextSmall > a')
    artist_links.each do |link|
      begin
        a = Artist.create(:profile_url => "http://www.the-athenaeum.org/people/#{link['href']}")
        puts "Created artist #{a.name} and relevant paintings"
      rescue
        puts "failed for #{link.text}"
      end
    end
  end
end