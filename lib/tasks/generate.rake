namespace :generate do
  require 'open-uri'
  # def generate_artist(link)

  # end

  # desc 'load paintings by artist'
  # task :all_artists => :environment do
  #   page = Nokogiri::HTML(open('http://www.the-athenaeum.org/people/list.php?sort=name_up&ltr=!'))
  #   artist_links = page.css('.r1 .TextSmall > a') + page.css('.r2 .TextSmall > a')
  #   puts artist_links.count
  #   artist_links.each do |link|
  #     puts link.text
  #     ArtistWorker.perform_async(link['href'])
  #   end
  # end

  desc 'load by museum'
  task :all_museums => :environment do
    page = Nokogiri::HTML(open('http://www.the-athenaeum.org/art/counts.php?s=ou&m=o'))
    # (page.css('.r2') + page.css('.r1'))
    (page.css('.r2')).each do |row|
      link = row.css('td').first.css('a').first
      href = link['href']
      if link.text > 'The Barnes Foundation'
        puts href
        puts "scrape #{link.text}"
        count = 1
        begin
          sleep 1
          MuseumGenerator.new("http://www.the-athenaeum.org#{href}")
        rescue
          count += 1
          retry if count < 3
        end
      else
        puts "Skip #{link.text}"
      end
    end
  end

end