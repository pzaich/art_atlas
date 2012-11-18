class Painting < ActiveRecord::Base
	attr_accessor :resource_url
  attr_accessible :gmaps, :latitude, :longitude, :artist, :address
  acts_as_gmappable

  def gmaps4rails_address
  	"#{self.address}"
  end

end
