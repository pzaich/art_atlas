class MuseumsController < ApplicationController
  def index
    sleep 5
    @museums = Search.new(params[:query], params[:location]).museums
  end
  
end
