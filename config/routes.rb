ArtAtlas::Application.routes.draw do
  # resources :museums, only: [:index, :show]
  # resources :artists, only: [:index, :show]
  root :to => 'static#home'
  namespace :api, defaults: { format: :json} do
    resources :museums, only: [:index, :show]
    resources :paintings, only: [:index]
    resources :artists, only: [:index]
  end

  namespace :admin do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/*path', to: 'static#home'
end
