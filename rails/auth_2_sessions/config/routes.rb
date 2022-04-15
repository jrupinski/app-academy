AuthDemo::Application.routes.draw do
  root to: 'users#new'
  resources :users, only: %i[index new create]
end
