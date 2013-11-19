class MuseumsController < ApplicationController
  def index
    @museums = Search.new(params[:query], params[:location]).museums
    respond_to do |f|
      f.json {}
      f.html { render 'static/home'}
    end
  end

  def show
    @museum = Museum.find params[:id]
    @artist = Artist.search_by_name(params[:query]).first
    @paintings = @museum.paintings(params[:query])
  end
  
end
