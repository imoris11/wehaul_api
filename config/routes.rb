Rails.application.routes.draw do
  
  #users routes
    resources :users do
      member do
        put :update_profile
      end
    end
    post 'signup', to: 'users#create'
    post "auth/login", to: "authentication#authenticate"
end
