class MuseumsController < ApplicationController
  def index
    @museums = Search.new(params[:query], params[:location]).museums
  end
  
end
