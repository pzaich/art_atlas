class Artist < ActiveRecord::Base
  include PgSearch

  attr_accessible :name

  has_many :paintings, :dependent => :destroy
  has_many :museums, :through => :paintings, :uniq => true

  validates :name, uniqueness: { case_sensitive: false }

  pg_search_scope :search_by_name,
                  :against => :name,
                  :using => { :tsearch => {:any_word => true, :prefix => true}}

end
