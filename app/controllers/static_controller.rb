class StaticController < ApplicationController
  def home
    #@museums = Museum.all.to_gmaps4rails
    @paintings = Painting.mappable.collect{ |painting| {
        :lat => painting.latitude, 
        :lng => painting.longitude,
        :title => painting.name, 
        :description => render_to_string(:partial => 'paintings/infobox', :locals => {:painting => painting})
      }
    }.to_json
  end
end
