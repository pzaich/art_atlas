class Painting < ActiveRecord::Base
	require 'open-uri'
	attr_accessor :painting_url
  attr_accessible :gmaps, :artist, :address, :painting_url, :name, :image, :museum
  belongs_to :artist
  belongs_to :museum
  #acts_as_gmappable
  before_create :build_portrait_profile
  has_attached_file :image, 
    :styles => {:small => "200x", :thumb => "200x200>"},
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/aws_s3.yml",
    :path => "painting/:attachment/:style/:id.:extension",
    :bucket => "artatlas"

  # def gmaps4rails_address
  # 	"#{self.address}"
  # end
  scope :mappable, where("museum_id is NOT NULL")

  def build_portrait_profile
  	f = open(self.painting_url, "User-Agent" => "Ruby")
  	page = Nokogiri::HTML(f)
  	set_name(page)
    set_address(page)
    process_image(page) 
  	f.close
  end

  def set_name(page)
  	self.name = page.css('#title').first.text
  end

  def set_address(page)
    raw_address = page.css('#generalInfo td')[1].text.chomp.strip
    if raw_address.casecmp("Private collection") != 0
      self.address = raw_address
      set_museum
    end    
  end

  def set_museum
    self.museum = Museum.find_or_create_by_name(self.address)
  end

  def process_image(page, location = "#{Rails.root}/tmp/#{self.name}.jpg")
    save_image_to_tmp(page, location)
    set_attachment(location)
    delete_image(location)
  end

  def save_image_to_tmp(page, location)
    img_src = page.css('#imgTextHolder img').first['src']
    File.open(location , 'wb') do |saved_file|
      open("http://www.the-athenaeum.org/art/#{img_src}", 'rb') do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end

  def set_attachment(location)
    self.image = File.open(location)
  end

  def delete_image(location)
    File.delete(location)
  end

  def latitude
    self.museum.latitude if self.museum
  end

  def longitude
    self.museum.longitude if self.museum
  end

  def self.to_mappable_json
    paintings = self.mappable.collect{|painting| {"lat" => painting.latitude, "lng" => painting.longitude}}
    paintings.to_json
  end
 


end
