Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'users', to: 'users#index', as: 'users'
  # post 'users', to: 'users#create'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :users, only: %i[create destroy index show update]
  resources :artworks, only: %i[create destroy show update] do
    post :favorite, on: :member
  end

  resources :artwork_shares, only: %i[create destroy] do
    post :favorite, on: :member
  end

  resources :comments, only: %i[create destroy index] do
    post :favorite, on: :member
  end
end
