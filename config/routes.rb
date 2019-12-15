Rails.application.routes.draw do
  
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
