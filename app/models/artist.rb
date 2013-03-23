class Artist < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :profile_url
  attr_accessible :name, :profile_url
  has_many :paintings
  after_create :build_artist_profile
  validates_presence_of :profile_url

  def build_artist_profile
    #sample artist profile http://www.the-athenaeum.org/people/detail.php?ID=4820
  	page = Nokogiri::HTML(open(self.profile_url, "User-Agent" => "Ruby"))
  	set_name(page)
    listing_page = Nokogiri::HTML(open("http://www.the-athenaeum.org#{page.css('#linkbar a')[2]['href']}"))
    #sample url http://www.the-athenaeum.org/art/list.php?m=a&s=tu&aid=4820
  	handle_multiple_page_listings(listing_page)
  end

  def set_name(page)
  	self.name = page.css('#title').text.chomp.strip
  end

  def create_artist_paintings(page)
  	page.css('.list_title a').each_with_index do |link, index|
      begin
        sleep 1
    		painting_link = "http://www.the-athenaeum.org/art/#{link['href']}"
    		self.paintings.build(:painting_url => painting_link)
        self.save
      rescue
        "rescued http://www.the-athenaeum.org/art/#{link['href']}"
      end
  	end
  end

  def handle_multiple_page_listings(page)
    art_pages_links = page.css('.subtitle a')[1..-1]
    if art_pages_links
      art_pages_links.each do |link|
        subpage_link = "http://www.the-athenaeum.org#{link['href']}"
        puts "multiple page link: #{subpage_link}"
        subpage = Nokogiri::HTML(open(subpage_link, "User-Agent" => "Ruby"))
        create_artist_paintings(subpage)
      end
    else
      create_artist_paintings(page)
    end
  end


end
