class Museum < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude, :name
  reverse_geocoded_by :latitude, :longitude
  acts_as_gmappable

  has_many :paintings
  has_many :artists, :through => :paintings , :uniq => true

  def gmaps4rails_address
    "#{self.name}"
  end
end
