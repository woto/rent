Rails.application.routes.draw do

  root to: 'maps#index'

  resources :areas do
    get :find__id__by__map_id__and__ref, on: :collection
  end

  resources :maps
  resources :renters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
