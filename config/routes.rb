Rails.application.routes.draw do
  
  resources :support_tickets
  resources :trip_activities
  resources :driver_payments
  resources :routes
  resources :payment_transactions
  resources :wallets
  resources :notifications
  resources :driver_requests
  resources :trip_requests
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
