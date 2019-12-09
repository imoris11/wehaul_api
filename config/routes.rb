Rails.application.routes.draw do
  
  #users routes
    resources :users 
    post 'signup', to: 'users#create'
    post "auth/login", to: "authentication#authenticate"
end
