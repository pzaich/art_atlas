class ArtistGenerator
  require 'open-uri'
  def initialize(link)
    @link = link
  end

  def create_artist
    # begin
      a = Artist.create(:profile_url => "http://www.the-athenaeum.org/people/#{@link}")
      puts "Created artist #{a.name} and relevant paintings"
      if a.paintings.empty?
        a.destroy
      end
    # rescue
    #   puts "failed for #{@link}"
    # end
  end

end