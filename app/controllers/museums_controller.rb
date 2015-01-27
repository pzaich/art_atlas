class MuseumsController < ApplicationController
  def index
    respond_to do |f|
      f.html { render 'static/home'}
    end
  end

  # def show
  #   @museum = Museum.find params[:id]
  #   @artist = Artist.search_by_name(params[:query]).first
  #   @paintings = @museum.paintings(params[:query])
  #   respond_to do |f|
  #     f.js
  #     f.html do
  #       params[:location] = @museum.to_coordinates
  #       render 'static/home'
  #     end
  #   end
  # end

end
