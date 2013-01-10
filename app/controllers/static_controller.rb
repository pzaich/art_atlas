class StaticController < ApplicationController
  def home
    @museums = Museum.all.to_gmaps4rails
  end
end
