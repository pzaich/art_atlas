class Museum < ActiveRecord::Base
  include PgSearch

  attr_accessible :latitude, :longitude, :name
  reverse_geocoded_by :latitude, :longitude

  has_many :paintings
  has_many :artists, :through => :paintings , :uniq => true

  pg_search_scope :search_by_artist, 
                  :associated_against => { :artists => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}

  def paintings(name=nil)
    !name.blank? ? self.paintings.search_by_artist(name) : super
  end

end
  