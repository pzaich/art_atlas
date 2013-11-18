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
    @paintings = Museum.paintings(params[:query])
  end
  
end
