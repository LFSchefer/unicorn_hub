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
    resources :unicorn_tags, only: [:new, :create, :edit, :update, :destroy]
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create, :destroy]
  end
  resources :bookings, only: [:index, :destroy]
  # resources :review, only: [:destroy]

end
