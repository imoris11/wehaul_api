Rails.application.routes.draw do
  resources :schedules
  resources :videos do
    collection do
      get :mine
      get :recent
    end
    member do
      put :update_views
    end
  end
  resources :categories
  resources :articles do
    collection do
      get :mine
      get :recent
    end

    member do
      put :update_views
    end
  end
  resources :users 
  post 'signup', to: 'users#create'
  post "auth/login", to: "authentication#authenticate"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
