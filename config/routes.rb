Rails.application.routes.draw do
  
  resources :support_tickets
  resources :trip_activities do
    collection do
      get :all_activities
    end
  end
  resources :driver_payments do
    collection do
      get :own #drivers own payments
    end
  end
  resources :routes

  resources :payment_transactions do
    collection do
      post :wallet_topup
      get :own
    end
  end
  
  resources :wallets do
    collection do
      get :balance
      put :update_balance
    end
  end
  resources :notifications
  resources :driver_requests
  resources :trip_requests do
    collection do
      get :trips
      get :trips_stats
      get :request_stats
      get :cancelled_requests
      get :active_requests 
      get :completed_trips
      get :cancelled_trips
      get :pending_trips
      get :on_going_trips
    end
    member do
      get :activities 
    end
  end
  resources :vehicle_images
  resources :vehicles
  resources :vehicle_types
  #users routes
    resources :users do
      member do
        put :update_profile
      end
    end
    post 'signup', to: 'users#create'
    post "auth/login", to: "authentication#authenticate"
end
