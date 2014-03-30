module Api
  class ArtistsController < ApiController
    
    def index
      @artists = Artist.search_by_name(params[:query])
      render :json => @artists.pluck(:name)
    end

  end
end