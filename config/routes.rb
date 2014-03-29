ArtAtlas::Application.routes.draw do
  resources :museums, only: [:show, :index]
  resources :artists, only: [:show, :index]
  root :to => 'static#home'
  get 'location/:location', :to => 'static#home'
  get '/:query/:location', :to => 'static#home'
  
  namespace :api do
    resources :museums, only: [:show, ]
    resources :artists, only: [:index]
  end
end
