class Painting < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :painting_url
  attr_accessible :gmaps, :latitude, :longitude, :artist, :address, :painting_url, :name
  acts_as_gmappable
  before_validation :build_portrait_profile

  def gmaps4rails_address
  	"#{self.address}"
  end

  def build_portrait_profile
  	page = Nokogiri::HTML(open(self.painting_url))
  	set_name(page)
  end

  def set_name(page)
  	self.name = page.css('span#lblTitle').first.text
  end


end
