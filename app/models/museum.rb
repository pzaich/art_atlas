class Museum < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude, :name
  acts_as_gmappable
  has_many :paintings

  def gmaps4rails_address
    "#{self.name}"
  end
end
