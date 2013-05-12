class ArtistsController < ApplicationController
  def index
    @artists = Artist.search_by_name(params[:query])
    render :json => @artists.map {|a| a.name }
  end
end
