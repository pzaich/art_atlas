class Artist
  module ProfileBuilder
    def create_artist_paintings(page)
      page.css('.list_title a').each_with_index do |link, index|
        attempts = 0
        begin
          painting_link = "http://www.the-athenaeum.org/art/#{link['href']}"
          PaintingGenerator.new(painting_link, self)
        rescue
          if attempts == 0
            sleep 5
            attempts += 1
            retry
          else 
            puts "rescued http://www.the-athenaeum.org/art/#{link['href']}"
          end
        end
      end
    end

    private

      def set_name(page)
        self.name = page.css('#title').text.chomp.strip
      end

      def handle_multiple_page_listings
        art_pages_links = @listing_page.css('.subtitle a')[1..-1]
        if !art_pages_links.empty?
          art_pages_links.each do |link|
            subpage_link = "http://www.the-athenaeum.org#{link['href']}"
            puts "multiple page link: #{subpage_link}"
            subpage = Nokogiri::HTML(open(subpage_link))
            create_artist_paintings(subpage)
          end
        else
          create_artist_paintings(@listing_page)
        end
      end

  end
end