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
      @paintings = @paintings.near(@location, 40)
    else
      @paintings
    end
  end
end
