class MuseumsController < ApplicationController
  def index
    @museums = Museum.all.to_gmaps4rails
    respond_to do |format|
      format.json{ render :json => @museums }
    end
  end
end
