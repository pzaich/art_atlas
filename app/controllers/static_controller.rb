class StaticController < ApplicationController
  def home
    @paintings = Search.new(params[:query], params[:location]).paintings
    @paintings = @paintings.mappable.collect{ |painting| {
        :lat => painting.latitude, 
        :lng => painting.longitude,
        :title => painting.name, 
        :description => render_to_string(:partial => 'paintings/infobox', :locals => {:painting => painting})
      }
    }.to_json
  end
end
