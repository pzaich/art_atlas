class Museum < ActiveRecord::Base
  include PgSearch

  attr_accessible :latitude, :longitude, :name, :address, :avatar
  geocoded_by :address_or_name

  validates :name, :uniqueness => true

  has_many :paintings
  has_many :artists, :through => :paintings , :uniq => true
  has_attached_file :avatar,
    :styles => {:small => "x200", :thumb => "200x200#"},
    :path => "museum/:attachment/:style/:id.:extension",
    :convert_options => { :all => '-quality 75 -strip -interlace Line' },
    :default_url => 'http://lorempixel.com/output/city-q-g-200-200-6.jpg'
  after_validation :geocode

  default_scope { where{ latitude != nil && longitude != nil }}
  scope :uncoded, -> {where{ latitude == nil && longitude == nil }}

  pg_search_scope :search_by_artist,
                  :associated_against => { :artists => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}

  def paintings(name= nil)
    !name.blank? ? self.paintings.search_by_artist(name) : super
  end

  def has_coordinates
    latitude && longitude
  end

  def address_or_name
    if !address.blank?
      address
    else
      name
    end
  end

end
