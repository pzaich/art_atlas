class StaticController < ApplicationController
  def home
    @museums = Search.new(params[:query], params[:location]).museums
    # @paintings = @paintings.collect{ |painting| {
    #     :lat => painting.latitude, 
    #     :lng => painting.longitude,
    #     :title => painting.name, 
    #     :description => render_to_string(:partial => 'paintings/infobox', :locals => {:painting => painting})
    #   }
    # }.to_json
    @museums = @museums.collect do |museum|
      { :lat => museum.latitude,
      :lng => museum.longitude,
      :title => museum.name,
      :description => render_to_string(:partial => 'museums/infobox', :locals => {:museum => museum, :paintings => museum.paintings(params[:query])})
      }
    end.to_json
  end
end
