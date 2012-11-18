class Artist < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :profile_url
  attr_accessible :name, :profile_url
  has_many :paintings
  before_validation :build_artist_profile
  validates_presence_of :profile_url

  def build_artist_profile
  	page = Nokogiri::HTML(open(self.profile_url))
  	set_name(page)
  	create_artist_paintings(page)
  end

  def set_name(page)
  	self.name = page.css('tr#trartworks b').first.text.gsub(/\t/, '').strip.split(',').reverse.join(' ')
  end

  def create_artist_paintings(page)
  	page.css('table#Datalist1 a').each do |link|
  		painting_link = link['href'].gsub('../../..', 'http://www.angel-art-house.com')
  		begin
  			self.paintings.build(:painting_url => painting_link)
  		rescue
  			"rescued"
  		end
  	end
  end

end
