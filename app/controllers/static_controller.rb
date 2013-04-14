class StaticController < ApplicationController
  def home
    if !params[:query].blank?
      @paintings = Search.new(params[:query], params[:location]).paintings
    else
      @paintings = Painting.scoped
    end
    @paintings = @paintings.mappable.collect{ |painting| {
        :lat => painting.latitude, 
        :lng => painting.longitude,
        :title => painting.name, 
        :description => render_to_string(:partial => 'paintings/infobox', :locals => {:painting => painting})
      }
    }.to_json
  end
end
