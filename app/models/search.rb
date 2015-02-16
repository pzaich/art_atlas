class Search
  attr_reader :museums
  def initialize(query, location, radius = 40)
    @query = query
    @location = location
    @radius = radius
    find_museums_by_artist_name
    filter_location
    keep_or_expand_search
    @museums = Museum.order('RANDOM()').limit(20) if query.blank? && location.blank?
  end

  def find_museums_by_artist_name
    if !@query.blank?
      @museums = Museum.search_by_artist(@query)
    else
      @museums = Museum
    end
  end

  def filter_location
    if !@location.blank?
      convert_to_coordinates if are_coordinates?
      @museums = @museums.near(@location, @radius)
    else
      @museums
    end
  end

  def keep_or_expand_search
    if @location.present? && @museums.size < 3 && @radius < 5000
      @museums = Search.new(@query, @location, @radius * 2.5).museums
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
