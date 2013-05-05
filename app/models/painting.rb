class Painting < ActiveRecord::Base
  include PgSearch
  attr_accessor :painting_url
  attr_accessible :gmaps, :artist, :address, :painting_url, :name, :image, :museum, :museum_id
  belongs_to :artist
  belongs_to :museum

  before_validation :set_coordinates!

  reverse_geocoded_by :latitude, :longitude

  has_attached_file :image, 
    :styles => {:small => "200x", :thumb => "200x200#"},
    :storage => :s3,
    :path => "painting/:attachment/:style/:id.:extension",
    :convert_options => { :all => '-interlace Line' }
  validates_presence_of :museum_id
  validates_uniqueness_of :name, :scope => :artist_id
  scope :mappable, where("museum_id is NOT NULL")
  pg_search_scope :search_by_artist, 
                  :associated_against => { :artist => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}



  
  def set_coordinates!
    if (self.latitude.nil? || self.longitude.nil?) && self.museum
      self[:longitude] = self.museum.longitude
      self[:latitude] = self.museum.latitude
    end
  end

  def self.to_mappable_json
    paintings = self.mappable.collect{|painting| {:lat => painting.latitude, :lng => painting.longitude,:title => painting.name, :description => "hello"}}
    paintings.to_json
  end 

end
