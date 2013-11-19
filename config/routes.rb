ArtAtlas::Application.routes.draw do

  root :to => 'static#home'
  resources :museums
  get '/:query/:location', :to => 'static#home'
  resources :artists
  
end
