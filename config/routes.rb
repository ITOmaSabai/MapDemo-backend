Rails.application.routes.draw do
  get 'home/index'
  namespace :api do
    namespace :v1 do
      resources :maps, only: [:create, :show, :index, :update, :destroy]
      resources :videos, only: [:create, :show, :index, :update, :destroy]
    end
  end
  
end
