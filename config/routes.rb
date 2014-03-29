ArtAtlas::Application.routes.draw do
  resources :museums, only: [:index, :show]
  resources :artists, only: [:index, :show]
  root :to => 'static#home'
  get 'location/:location', :to => 'static#home'
  get '/:query/:location', :to => 'static#home'
  
  namespace :api do
    resources :museums, only: [:index, :show]
    resources :artists, only: [:index]
  end
end
