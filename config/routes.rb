Rails.application.routes.draw do
  devise_for :users
  root to: "unicorns#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :unicorns do
    collection do
      get :timer
    end
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end
  resources :bookings, only: [:index]
end
