ArtAtlas::Application.routes.draw do

  root :to => 'static#home'
  get '/:query/:location', :to => 'static#home'
  resources :museums
  resources :artists
  
end
