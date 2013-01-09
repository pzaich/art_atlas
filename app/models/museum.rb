class Museum < ActiveRecord::Base
  attr_accessor :location
  attr_accessible :gmaps, :latitude, :longtitude, :name, :location
  acts_as_gmappable
  has_many :paintings

  def gmaps4rails_address
    "#{self.location}"
  end
end
