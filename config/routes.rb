ArtAtlas::Application.routes.draw do

  root :to => 'static#home'
  resources :museums, :only => :index
  resources :artists
  
end
