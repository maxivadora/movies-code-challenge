Rails.application.routes.draw do
  ## API
  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create, :show, :update, :destroy]
      resources :movies, only: [:index, :create, :show, :update, :destroy]
      post 'login', to: 'authentication#login'
    end
  end
  
  ## Website

  root to: 'home#index'
  resources :movies, only: [:index, :show]
  get 'search', to: 'searches#search'
end
