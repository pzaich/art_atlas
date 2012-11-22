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
  	f.close
  end

  def set_name(page)
  	self.name = page.css('#title').first.text
  end

  def set_address(page)
    self.address = page.css('#generalInfo td')[1].text.chomp.strip
  end


end
