class Artist < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :profile_url
  attr_accessible :name, :profile_url
  before_validation :build_artist_profile
  validates_presence_of :profile_url


  def build_artist_profile
  	page = Nokogiri::HTML(open(self.profile_url))
  	set_artist_name(page)
  end

  def set_artist_name(page)
  	self.name = page.css('tr#trartworks b').first.text.gsub(/\t/, '').strip.split(',').reverse.join(' ')
  end

  def create_artist_paintings

  end





end
