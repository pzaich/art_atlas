class Museum < ActiveRecord::Base
  include PgSearch

  attr_accessible :latitude, :longitude, :name, :address
  geocoded_by :address

  validates :name, :uniqueness => true
  # validates :latitude, :presence => true
  # validates :longitude, :presence => true

  has_many :paintings
  has_many :artists, :through => :paintings , :uniq => true

  pg_search_scope :search_by_artist, 
                  :associated_against => { :artists => :name},
                  :using => { :tsearch => {:dictionary => 'english'}}

  def paintings(name= nil)
    !name.blank? ? self.paintings.search_by_artist(name) : super
  end

  # def address_or_name
  #   if !address.blank?
  #     address
  #   else
  #     name
  #   end
  # end

end
  