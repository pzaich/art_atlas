module Api
  class MuseumsController < ApiController
    def index
      @museums = Search.new(params[:query], params[:location]).museums
      flash[:notice] = "Sorry we couldn't find anything nearby that matches your search."
    end

    def show
      @museum = Museum.find params[:id]
      @artist = Artist.search_by_name(params[:query]).first
      @paintings = @museum.paintings(params[:query])
      respond_with @museum
    end
  end
end