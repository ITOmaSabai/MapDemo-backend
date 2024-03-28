Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :maps, only: [:create, :show, :index, :update, :destroy]
      resources :videos, only: [:create, :show, :index, :update, :destroy] do
        post 'search', on: :collection
      end
      resources :addresses, only: [:index]
      resources :users, :likes, only: [:index, :create, :destroy]
      resource :authentication, only: [:create]
      resources :feedbacks, only: [:index, :create]
    end
  end

  get 'api/v1/profile', to: 'api/v1/users#show'
  get 'api/v1/search', to: 'api/v1/users#search'
  get '*path', to: 'home#index'
  root to: 'home#index'
end
