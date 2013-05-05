require 'open-uri'

class PaintingGenerator
  attr_reader :painting
  
  def initialize(painting_url, artist)
    @painting_url = painting_url
    build_profile
    @painting = Painting.create(:name => @name, 
                    :address => @address, 
                    :museum => @museum, 
                    :image => @image,
                    :artist => artist)
  end

  private
    def build_profile
      f = open(@painting_url, "User-Agent" => "Ruby")
      page = Nokogiri::HTML(f)
      set_name(page)
      set_address(page)
      process_image(page)
      f.close
    end

    def set_name(page)
      @name = page.css('#title').first.text
    end

    def set_address(page)
      raw_address = page.css('#generalInfo td')[1].text.chomp.strip
      if (raw_address =~ /private collection|unknown/i).nil?
        @address = raw_address
        set_museum
      end    
    end

    def set_museum
      @museum = Museum.find_or_create_by_name(@address)
    end
    #rails root is not in this file
    def process_image(page)
      location = "#{Rails.root}/tmp/#{@name}.jpg"
      save_image_to_tmp(page, location)
      #set_attachment(location)
      #delete_image(location)
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
      @image = File.open(location)
    end

    def delete_image(location)
      File.delete(location)
    end
end