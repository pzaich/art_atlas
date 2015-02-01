class Painting < ActiveRecord::Base
  include PgSearch
  attr_accessor :painting_url
  attr_accessible :artist, :address, :painting_url, :name, :image, :museum, :museum_id, :athenaeum_id

  belongs_to :artist
  belongs_to :museum
  has_attached_file :image,
    :styles => {:small => "x200", :thumb => "500x500#"},
    :path => "painting/:attachment/:style/:id.:extension",
    :convert_options => { :all => '-quality 75 -strip -interlace Line' }

  validates_presence_of :museum_id
  validates :athenaeum_id, :uniqueness => true

  scope :mappable, where("museum_id is NOT NULL")
  pg_search_scope :search_by_artist,
                  :associated_against => { :artist => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}

  paginates_per 50
end
