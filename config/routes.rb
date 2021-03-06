Rails.application.routes.draw do

  get 'dashboard/index'

  resources :transactions
  resources :contracts

  resources :areas do
    get :find__id__by__map_id__and__ref, on: :collection
    get :today_renter, on: :member
  end

  resources :maps
  resources :renters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: 'dashboard#index'

end
