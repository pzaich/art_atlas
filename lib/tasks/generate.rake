namespace :generate do
  require 'open-uri'
  def generate_artist(link)
    
  end

  desc 'load paintings by artist'
  task :all_artists => :environment do
    page = Nokogiri::HTML(open('http://www.the-athenaeum.org/people/list.php?sort=name_up&ltr=!'))
    artist_links = page.css('.r1 .TextSmall > a') + page.css('.r2 .TextSmall > a')
    puts artist_links.count
    artist_links.each do |link|
      puts link.text
      ArtistWorker.perform_async(link['href'])
    end
  end
end