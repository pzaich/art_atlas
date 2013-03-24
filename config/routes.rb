ArtAtlas::Application.routes.draw do

  root :to => 'static#home'
  resources :museums
  
end
