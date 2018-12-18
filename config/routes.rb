Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create, :show, :update, :destroy]
      resources :movies, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
