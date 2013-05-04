class Painting
  module ProfileBuilder
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
  end
end