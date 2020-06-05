Rails.application.routes.draw do
  
  resources :trackings
  resources :driver_routes, only: [:show, :update, :destroy] do
    member do
      post :create_routes
      get :driver_routes
    end
  end
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
    member do
      get :payments
    end
  end
  resources :routes do
    collection do
      get :stats
    end
  end

  resources :payment_transactions do
    collection do
      post :wallet_topup
      get :own
    end
    member do
      get :transactions
    end
  end
  
  resources :wallets do
    collection do
      get :balance
      put :update_balance
    end
    member do
      get :user_wallet
    end
  end
  resources :notifications
  resources :driver_requests do
    member do
      get :trip_driver_requests
    end
  end
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
      put :pay
      get :accepted_driver_requests
      put :assign
      put :assign_driver
      get :tracking
    end
  end
  resources :vehicle_images
  resources :vehicles do 
    member do
      post :create_vehicle
    end
  end
  resources :vehicle_types do
    collection do
      get :stats
    end
  end

  resources :users do
    member do
      put :update_profile
    end
  end
  #admins endpoints
  namespace :admins do
    resources :drivers do
      member do
        put :update_profile
        get :ban
        get :busy
        get :driver_information
        get :vehicles
        get :trips
        get :trip_drivers
      end
      collection do
        get :stats
      end
    end
    resources :customers do
      collection do
        get :stats
      end
      member do
        put :update_profile
        get :ban
        get :trips
      end
    end
    resources :requests do
      collection do
        #trip and requests for admins
        get :requests
        get :trips
        get :trips_stats
        get :request_stats
        get :cancelled_requests
        get :active_requests 
        get :completed_trips
        get :cancelled_trips
        get :pending_trips
        get :on_going_trips
        get :monthly_trips
        post :create_request
      end
      member do
        get :show_request
        get :activities
        put :update_request
      end
    end
    resources :accounts, only: [:index] do
      collection do
        get :stats
      end
    end
  end

  #driver endpoints
  namespace :drivers do
    resources :accounts, only: [:index] do
      collection do
        get :stats
        get :busy
      end
    end
    resources :requests, only:[:index] do
      collection do
        get :history
        get :cancelled
        get :completed 
        get :pending 
        get :on_going 
        get :driver_requests
        get :driver_stats
        get :stats
      end
    end
    resources :trip_activities
  end
  
  post 'signup', to: 'users#create'
  post "auth/login", to: "authentication#authenticate"
  put "auth/change_password", to: "users#change_password" 
end
