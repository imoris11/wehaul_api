Rails.application.routes.draw do
  namespace :customers do
    resources :users 
    post 'signup', to: 'users#create'
    post "auth/login", to: "authentication#authenticate"
  end
end
