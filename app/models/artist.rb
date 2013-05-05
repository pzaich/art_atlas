class Artist < ActiveRecord::Base
	require 'open-uri'
  include ProfileBuilder

	attr_accessor :profile_url
  attr_accessible :name, :profile_url
  has_many :paintings, :dependent => :destroy
  before_validation :build_artist_profile, :on => :create
  after_commit :load_paintings, :on => :create
  validates_presence_of :profile_url
  validates_uniqueness_of :name

  #sample artist profile http://www.the-athenaeum.org/people/detail.php?ID=4820
  def build_artist_profile
    page = Nokogiri::HTML(open(self.profile_url, "User-Agent" => "Ruby"))
    set_name(page)
    @listing_page = Nokogiri::HTML(open("http://www.the-athenaeum.org#{page.css('#linkbar a')[2]['href']}"))
  end

  #sample url http://www.the-athenaeum.org/art/list.php?m=a&s=tu&aid=4820
  def load_paintings
    handle_multiple_page_listings
  end
end
