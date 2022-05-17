Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'sessions#new'

  resource :session, only: %i[new create destroy]
  resources :users, only: %i[show new create]
  resources :goals
  resources :user_comments, only: %i[create]
  resources :goal_comments, only: %i[create]
  resources :comments, only: %i[create]

end
