Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'sessions#new'

  resource :session, only: %i[new create destroy]
  resources :users
  resources :bands do
    resources :albums, only: :new
  end
  resources :albums, except: %i[index new] do
    resources :tracks, only: :new
  end
  resources :tracks, except: :new
  resources :notes, only: %i[create destroy]
end
