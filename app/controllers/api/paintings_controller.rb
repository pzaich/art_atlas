module Api
  class PaintingsController < ApiController

    def index
      @museum    = Museum.find(params[:museum_id])
      @paintings = @museum.paintings(params[:query]).includes(:artist)
    end

  end
end