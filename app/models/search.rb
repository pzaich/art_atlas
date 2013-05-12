class Search
  attr_reader :museums
  def initialize(query, location)
    @query = query
    @location = location
    find_museums_by_artist_name
    filter_location
    @museum = @museums.shuffle[0,100] if query.blank? && location.blank?
  end

  def find_museums_by_artist_name
    if !@query.blank?
      @museums = Museum.search_by_artist(@query)
    else
      @museums = Museum.scoped
    end
  end

  def filter_location
    if !@location.blank?
      convert_to_coordinates if are_coordinates?
      @museums = @museums.near(@location, 100)
    else
      @museums
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
      @location.split('%2C').collect!{|i| i.to_f}
    end
end
