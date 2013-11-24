ArtAtlas::Application.routes.draw do
  resources :museums
  resources :artists
  root :to => 'static#home'
  get 'location/:location', :to => 'static#home'
  get '/:query/:location', :to => 'static#home'
  
end
