Rails.application.routes.draw do
  namespace :drivers do
    resources :drivers
    post 'signup', to: 'drivers#create'
    post "auth/login", to: "authentication#authenticate"
  end
 
  namespace :customers do
    resources :users 
    post 'signup', to: 'users#create'
    post "auth/login", to: "authentication#authenticate"
  end
end
