class StaticController < ApplicationController
  def home
    @museums = Search.new(params[:query], params[:location]).museums
    flash.now[:notice] = "Sorry we couldn't find anything nearby that match your search." if @museums.empty?
    museums_to_json

  end

  private
    def museums_to_json
      @museums = @museums.collect do |museum|
        { :lat => museum.latitude,
        :lng => museum.longitude,
        :title => museum.name,
        :description => render_to_string(:partial => 'museums/infobox', :locals => {:museum => museum, :paintings => museum.paintings(params[:query])})
        }
      end.to_json
    end
end

