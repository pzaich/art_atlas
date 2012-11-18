class Artist < ActiveRecord::Base
	attr_accessor :profile_url
  attr_accessible :name, :profile_url

  validates_presence_of :profile_url
end
