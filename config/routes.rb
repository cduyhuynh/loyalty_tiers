Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/users/:id', to: 'static#index'
  get '/users/:id/orders', to: 'static#index'
  namespace :api, defaults: { format: 'json' } do
    namespace :orders do
      put :complete
    end

    resources :users, only: [:show] do
      get :orders
    end
  end

  root "static#index"
end
