class StaticController < ApplicationController
  def home
    @museums = Search.new(params[:query], params[:location])
    # @paintings = @paintings.collect{ |painting| {
    #     :lat => painting.latitude, 
    #     :lng => painting.longitude,
    #     :title => painting.name, 
    #     :description => render_to_string(:partial => 'paintings/infobox', :locals => {:painting => painting})
    #   }
    # }.to_json
  end
end
