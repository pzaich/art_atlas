class Search
  attr_reader :paintings
  def initialize(query, location)
    @query = query
    @location = location
    find_paintings_by_artist_name
    filter_location
  end

  def find_paintings_by_artist_name
    if !@query.blank?
      @paintings = Painting.search_by_artist(@query)
    else
      @paintings = Painting.scoped
    end
  end

  def filter_location
    if !@location.blank?
      convert_to_coordinates if are_coordinates?
      @paintings = @paintings.near(@location, 100)
    else
      @paintings
    end
  end
  private
    def are_coordinates?
      if @location.split(',').first =~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
        true
      else
        false
      end
    end

    def convert_to_coordinates
      @location.split('%2C').collect{|i| i.to_f}
    end
end
