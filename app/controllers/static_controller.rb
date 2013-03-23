class StaticController < ApplicationController
  def home
    @museums = Museum.all.to_gmaps4rails
    @paintings = Painting.to_mappable_json
  end
end
