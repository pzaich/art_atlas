class Painting < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :painting_url
  attr_accessible :gmaps, :latitude, :longitude, :artist, :address, :painting_url, :name
  belongs_to :artist
  #acts_as_gmappable
  before_validation :build_portrait_profile

  def gmaps4rails_address
  	"#{self.address}"
  end

  def build_portrait_profile
  	f = open(self.painting_url, "User-Agent" => "Ruby")
  	page = Nokogiri::HTML(f)
  	set_name(page)
    set_address(page)
    process_image(page) 
  	f.close
  end

  def set_name(page)
  	self.name = page.css('#title').first.text
  end

  def set_address(page)
    self.address = page.css('#generalInfo td')[1].text.chomp.strip
  end

  def process_image(page)
    save_image_to_tmp(page)
  end

  def save_image_to_tmp(page)
    img_src = page.css('#imgTextHolder img').first['src']
    File.open( "#{Rails.root}/tmp/#{self.name}" , 'wb') do |saved_file|
      open("http://www.the-athenaeum.org/art/#{img_src}", 'rb') do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end

 


end
