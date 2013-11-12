require 'open-uri'

class PaintingGenerator
  attr_reader :painting
  
  def initialize(painting_url, museum)
    @painting_url = painting_url
    build_profile
    @painting = Painting.new(:name => @name,
                    :museum => museum, 
                    :image => @image,
                    :artist => @artist,
                    :athenaeum_id => set_athenaeum_id
                    )
    if @painting.save
      puts "added painting #{painting.name}"
    else
      @painting.errors.each {|error, reason| puts "#{error} #{reason}"}
    end
    delete_image
  end

  private
    def build_profile
      f = open(@painting_url)
      page = Nokogiri::HTML(f)
      set_name(page)
      set_artist(page)
      process_image(page)
      f.close
    end

    def set_athenaeum_id
      @painting_url.slice! /\d{2,10}$/
    end

    def set_name(page)
      @name = page.css('#title').first.text
    end

    def process_image(page)
      @location = "#{Rails.root}/tmp/#{@name}.jpg"
      save_image_to_tmp(page)
      set_attachment
    end

    def save_image_to_tmp(page)
      img_src = page.css('#imgTextHolder img').first['src']
      File.open(@location , 'wb') do |saved_file|
        open("http://www.the-athenaeum.org/art/#{img_src}", 'rb') do |read_file|
          saved_file.write(read_file.read)
        end
      end
    end

    def set_attachment
      @image = File.open(@location)
    end

    def delete_image
      File.delete(@location)
    end

    def set_artist(page)
      artist_name = page.css('.subtitle a').first.text.strip
      @artist = Artist.where(name: artist_name).first_or_create
    end
end