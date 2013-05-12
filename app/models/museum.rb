class Museum < ActiveRecord::Base
  include PgSearch

  attr_accessible :gmaps, :latitude, :longitude, :name
  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable

  has_many :paintings
  has_many :artists, :through => :paintings , :uniq => true

  pg_search_scope :search_by_artist, 
                  :associated_against => { :artists => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}

  def gmaps4rails_address
    "#{self.name}"
  end

  def paintings(name=nil)
    if !name.blank?
      self.paintings.search_by_artist(name)
    else
      super
    end
  end

end
  