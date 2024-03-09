Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :maps, only: [:create, :show, :index, :update, :destroy]
      resources :videos, only: [:create, :show, :index, :update, :destroy]
      resources :addresses, only: [:index]
    end
  end

  get '*path', to: 'home#index'
  root to: 'home#index'
end
